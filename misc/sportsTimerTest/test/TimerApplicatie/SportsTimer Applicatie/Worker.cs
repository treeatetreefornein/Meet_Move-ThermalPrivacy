using System;
using System.Threading;
using System.ComponentModel;

public class Worker
{
    public event EventHandler Completed;
    public ISynchronizeInvoke SynchronizationObject { get; set; }

    public void Run()
    {
        ThreadPool.QueueUserWorkItem(new WaitCallback(DoWork));
    }

    protected virtual void DoWork(object state)
    {
        //Thread.Sleep(3000);
        if (Completed != null)
        {      // Ignore race...
            if (SynchronizationObject != null)
                SynchronizationObject.BeginInvoke(Completed, new object[] { this, EventArgs.Empty });
            else
                Completed(this, EventArgs.Empty);
        }
    }
}
