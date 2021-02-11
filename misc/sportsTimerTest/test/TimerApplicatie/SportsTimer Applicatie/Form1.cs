using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.IO;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SportsTimer_Applicatie
{
    public partial class Form1 : Form
    {
        Worker mWork = new Worker();
        private delegate void SafeCallDelegate(string text);

        public Form1()
        {
            InitializeComponent();

            mWork.SynchronizationObject = this;
            mWork.Completed += new EventHandler(mWork_Completed);

            port.DataReceived += new SerialDataReceivedEventHandler(port_DataReceived);
        }
        void mWork_Completed(object sender, EventArgs e)
        { 
            switch (buttonValArduino)
            {
                case "2": //Start Geel
                    System.Media.SoundPlayer player = new System.Media.SoundPlayer(Properties.Resources.mp443_shot_1);
                    player.Play();

                    startTimers();
                    break;
                case "3": //Geel A
                    resetSaveLoadNext();
                    reset_trackA();
                    break;
                case "4": //Rood A
                    stopTimerA();
                    break;
                case "5": //Rood B
                    stopTimerB();
                    break;
                case "6": //Geel B
                    resetSaveLoadNext();
                    reset_trackB();
                    break;

                //Pieces below where for prototyping
                case "9":
                    startTimers();
                    //check randvoorwaardes zoals valse start etc voordat ik verder ga met applicatie!
                    //resetSaveLoadNext();
                    break;
                default:
                    break;
            }
                
            Console.WriteLine(System.Threading.Thread.CurrentThread.ManagedThreadId);
        }
        //creating global timers
        Stopwatch swTrackA = new Stopwatch();
        Stopwatch swTrackB = new Stopwatch();
        TimeSpan tsTrackA = new TimeSpan();
        TimeSpan tsTrackB = new TimeSpan();
        static int name = 1;
        static string buttonValArduino = "";

        //selecting the serial port for communication
		//Change COM## to the number to the corrosponding comport (check documentation how to find this)
        private static SerialPort port = new SerialPort("COM10", 9600, Parity.None, 8, StopBits.One);

        private void Form1_Load(object sender, EventArgs e)
        {
            Form2 form2 = new Form2();

            form2.Show();
            MessageBox.Show("Sluit alle Excel bestanden voordat je verder gaat");
            //Opening serial Port, comment the line below out if you dont have a arduino connected
            port.Open();
            killExistingExcel();
            SerialPortProgram();
            loadNames(false);
        }

        //this function is to make sure that any excel processes will be killed so it will not interfere with the data.xlsx file
        public void killExistingExcel()
        {
            foreach (Process clsProcess in Process.GetProcesses())
            {
                if (clsProcess.ProcessName.Equals("EXCEL"))
                {
                    clsProcess.Kill();
                    break;
                }
            }
        }

        private void SerialPortProgram()
        {
            Console.ReadLine();
        }
        
        //this function is being called whenever data is received through the serial line as simple string, 
        private void port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            buttonValArduino = port.ReadExisting();
            Console.WriteLine(buttonValArduino); //only purpose is for debugging (checking what value we receive from the serial communication)
            
            mWork.Run();
        }
        //code for resetting, it will only load the new names and save their records if both players finished
        //keep in mind that BOTH timers must be stopped before continuation, if 1 of the runners is unable to finish stop the timer manually!
        public void resetSaveLoadNext()
        {
            if (!swTrackA.IsRunning && !swTrackB.IsRunning)
            {
                //code to safe timers in data.xlsx  
                loadNames(true);
                reset_Timers();
            }
            //incase of faulty start (check button type)
        }
        public void reset_trackA()
        {
            if (swTrackA.IsRunning)
            {
                swTrackA.Reset();
                lblTimerTrackA.Text = "0:00.000";
            }
        }

        public void reset_trackB()
        {
            if (swTrackB.IsRunning)
            {
                swTrackB.Reset();
                lblTimerTrackB.Text = "0:00.000";
            }
        }
        

        public void reset_Timers()
        {
            swTrackA.Reset();
            swTrackB.Reset();
            tsTrackA = swTrackA.Elapsed;
            tsTrackB = swTrackB.Elapsed;
            lblTimerTrackA.Text = "0:00.000";
            lblTimerTrackB.Text = "0:00.000";
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            tsTrackA = swTrackA.Elapsed;
            string time = string.Format("{0:D1}:{1:D2}.{2:D3}", tsTrackA.Minutes, tsTrackA.Seconds, tsTrackA.Milliseconds);
            lblTimerTrackA.Text = time+"";
        }

        private void timer2_Tick(object sender, EventArgs e)
        {
            tsTrackB = swTrackB.Elapsed;
            string time = string.Format("{0:D1}:{1:D2}.{2:D3}", tsTrackB.Minutes, tsTrackB.Seconds, tsTrackB.Milliseconds);
            lblTimerTrackB.Text = time + "";
        }
        public void startTimers()
        {
            if(tsTrackA.Milliseconds == 0 && tsTrackB.Milliseconds == 0) //both timers havent started yet
            {
                timer1.Start();
                swTrackA.Start();
                timer2.Start();
                swTrackB.Start();
            }
            else if(tsTrackB.Milliseconds > 0 && tsTrackA.Milliseconds == 0) // only restart the timer of person A
            {
                timer1.Start();
                swTrackA.Start();
            }
            else if(tsTrackA.Milliseconds > 0 && tsTrackB.Milliseconds == 0) // only restart the timer of person B
            {
                timer2.Start();
                swTrackB.Start();
            }
        }

        public void stopTimerA()
        {
            swTrackA.Stop();
            timer1.Stop();
            
        }

        public void stopTimerB()
        {
            swTrackB.Stop();
            timer2.Stop();
        }

        //this function saves both the names and their timers, this function is called whenever both participants 
        public void loadNames(bool saveTime)
        {
            string currentDirectory = Directory.GetCurrentDirectory();
            string filePath = Path.Combine(currentDirectory, "..\\..\\..\\Data", "data.xlsx");
            
            Excel excel = new Excel(filePath, 1);

            //check if the first names has to be shown, or their increment

            if(saveTime)
            {
                string timeA = string.Format("{0:D1}:{1:D2}.{2:D3}", tsTrackA.Minutes, tsTrackA.Seconds, tsTrackA.Milliseconds);
                excel.WriteToCell(name, 3, timeA);
                string timeB = string.Format("{0:D1}:{1:D2}.{2:D3}", tsTrackB.Minutes, tsTrackB.Seconds, tsTrackB.Milliseconds);
                excel.WriteToCell(name + 1, 3, timeB);
                excel.Save();
                //excel.SaveAs(filePath);
                name += 2;
            }

            lblNameTrackA.Text = excel.ReadCell(name, 2);
            lblNameTrackB.Text = excel.ReadCell(name + 1, 2);

            excel.Close();
            excel = null;
        }

        private void label2_Click(object sender, EventArgs e)
        {
            mWork_Completed(sender, e);
        }
    }
}
