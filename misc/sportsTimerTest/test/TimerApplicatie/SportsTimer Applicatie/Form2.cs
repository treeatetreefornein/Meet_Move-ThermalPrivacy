using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace SportsTimer_Applicatie
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }


        private void Form2_Load(object sender, EventArgs e)
        {
            dataGridView1.ColumnCount = 4;
            dataGridView1.Columns[0].Name = "Nr";
            dataGridView1.Columns[1].Name = "Rank";
            dataGridView1.Columns[2].Name = "Naam";
            dataGridView1.Columns[3].Name = "Tijd";

            dataGridView2.ColumnCount = 4;
            dataGridView2.Columns[0].Name = "Nr";
            dataGridView2.Columns[1].Name = "Rank";
            dataGridView2.Columns[2].Name = "Naam";
            dataGridView2.Columns[3].Name = "Tijd";
        }

        private void btnShow60_Click(object sender, EventArgs e)
        {
            dataGridView2.Show();
            tableLayoutPanel1.SetColumnSpan(dataGridView1, 1);
            loadExcel(61);
        }

        private void btnShow20_Click(object sender, EventArgs e)
        {
            dataGridView2.Hide();
            tableLayoutPanel1.SetColumnSpan(dataGridView1, 2);
            loadExcel(21);
        }

        private void btnShow10_Click(object sender, EventArgs e)
        {
            dataGridView2.Hide();
            tableLayoutPanel1.SetColumnSpan(dataGridView1, 2);
            loadExcel(11);
        }

        public void loadExcel(int numberOfDataShown)
        {
            dataGridView1.Rows.Clear();
            dataGridView1.Refresh();
            dataGridView2.Rows.Clear();
            dataGridView2.Refresh();

            string currentDirectory = System.IO.Directory.GetCurrentDirectory();
            string filePath = System.IO.Path.Combine(currentDirectory, "..\\..\\..\\Data", "data.xlsx");

            Excel excel = new Excel(filePath, 1);
            //fill the datagrid with the correct amount of data
            for (int i = 1; i < numberOfDataShown; i++)
            {
                //adding the correct 4 value's to the string array
                string nummer = excel.ReadCell(i, 0);
                string rank = excel.ReadCell(i, 1);
                string naam = excel.ReadCell(i, 2);
                string tijd = excel.ReadCell(i, 3);
                string[] row = { nummer, rank, naam, tijd };
                if(i <= 30)
                {
                    dataGridView1.Rows.Add(row);
                }
                else
                {
                    dataGridView2.Rows.Add(row);
                }
            }
            excel.Close();
            excel = null;
        }
    }
}
