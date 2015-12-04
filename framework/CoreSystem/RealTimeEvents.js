/*
 * RealTimeEvents.js
 *  Realtime Events handling and the scheduler
 *
 * John Willis
 * john@prefiniti.com
 *
 * Copyright (C) 2008, AJL Intel-Properties LLC 
 */


// task priorities
var TP_LOW				= 0;
var TP_NORMAL 			= TP_LOW;
var TP_MEDIUM			= 1;
var TP_HIGH 			= 2;
 
 
var PTasks = new Array(1);
var TaskID = 0;

function ClearTasks () 
{
	PTasks = new Array(1);
	TaskID = 0;
}

function PTask (TaskName, TaskFunction, Priority, Enabled, Owner) {
	this.TaskName = TaskName;
	this.TaskFunction = TaskFunction;
	this.Priority = Priority;
	this.Enabled = Enabled;
	this.Owner = Owner;
	this.RunCount = 0;
	this.TID = null;
}

PTask.prototype.Pause = function () {
	this.Enabled = false;
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="red">Pause</font>');
	
};

PTask.prototype.Resume = function () {
	this.Enabled = true;
	
	var sr = 'TaskStat_' + this.TID.toString();
	SetInnerHTML(sr, '<font color="orange">Wait</font>');
	
};

PTask.prototype.Run = function () {
	this.TaskFunction();
};

function PAddTask(Task) {
	PTasks[TaskID] = Task;
	PTasks[TaskID].TID = TaskID;
	
	TaskID++;
	
	return (TaskID - 1);
}

function PauseAllTasks() {
	for (i in PTasks) {
		PTasks[i].Pause();
	}
}

function ResumeAllTasks() {
	for (i in PTasks) {
		PTasks[i].Resume();
	}
}

function PMaxWait()
{
	var LastWait = 1;
	var MaxWait = 0;
	
	for (i in PTasks)
	{
		LastWait = PTasks[i].Priority;
		if (LastWait > MaxWait) {
			MaxWait = LastWait;
		}
	}
	
	return MaxWait;
}

var CurCycle = 0;
var TotalCycles = 0;
var IdleCycles = 0;
var ActiveCycles = 0;

function PRunTaskQueue ()
{
	var tsRef = null;
	var CycleCount = PMaxWait();
	var taskPercent = 0;
	var tasksInCycle = 0;
	
	for (i in PTasks) {
		tasksInCycle = 0;
		if (CurCycle < CycleCount) {
			CurCycle++;
		}
		else {
			CurCycle = 0;
		}
		TotalCycles++;
		
		SetInnerHTML('CMaxWait', CycleCount.toString());
		SetInnerHTML('CCycle', "RTE Usage: " +  parseInt((ActiveCycles * 100) / TotalCycles) + "%");
		
		if(PTasks[i]) {
			if (PTasks[i].Enabled) {
				if (!(CurCycle % PTasks[i].Priority)) {
					
					tasksInCycle++;
					tsRef = 'TaskStat_' + i.toString();
					SetInnerHTML(tsRef, '<font color="green">Run</font>');
					try {
						PTasks[i].Run();
						PTasks[i].RunCount++;
					}
					catch (ex) {
						writeConsole('Error in background service.');
					}
					
					SetInnerHTML(tsRef, '<font color="orange">Wait</font>');
					tsRef = 'TaskRC_' + i.toString();
					SetInnerHTML(tsRef, PTasks[i].RunCount.toString());
					
				}
			}
			tsRef = 'TaskPercent_' + i.toString();
			taskPercent = parseInt((PTasks[i].RunCount * 100) / (TotalCycles - IdleCycles));
			SetInnerHTML(tsRef, taskPercent + "%");
		}
		if (tasksInCycle == 0) {
			IdleCycles++;
		}
		else {
			ActiveCycles++;
		}
	}
	
	var b = window.setTimeout("PRunTaskQueue();", 1000);
}

function PEnableTaskQueue ()
{
	PRunTaskQueue();
}

function PAutoUpdater(ResourceURL, TargetDiv)
{
	var udf = function() {
		AjaxSilentLoad(TargetDiv, ResourceURL);
	};
	
	return udf;
}	

