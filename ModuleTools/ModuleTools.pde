import interfascia.*;

GUIController guiController;

IFButton loadModuleButton;
IFButton saveModuleButton;
IFButton removeSyncButton;
IFLookAndFeel grayLook;

byte[] moduleBytes;
Module module;

//**************************************************************************************
//
//**************************************************************************************
void setup() 
{
  size(640, 480);
  frameRate(60);
  background(200);
  
  guiController = new GUIController (this);
  
  grayLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  grayLook.baseColor = color(128, 128, 128);
  grayLook.highlightColor = color(96, 96, 96);
  
  loadModuleButton = new IFButton("Load module", 10, 10, 100, 17);
  loadModuleButton.addActionListener(this);
  guiController.add(loadModuleButton);
  loadModuleButton.setLookAndFeel(grayLook);
  
  removeSyncButton = new IFButton("Remove sync", 10, 30, 100, 17);
  removeSyncButton.addActionListener(this);
  guiController.add(removeSyncButton);
  removeSyncButton.setLookAndFeel(grayLook);
  
  saveModuleButton = new IFButton("Save sync", 10, 50, 100, 17);
  saveModuleButton.addActionListener(this);
  guiController.add(saveModuleButton);
  saveModuleButton.setLookAndFeel(grayLook);
}

//**************************************************************************************
//
//**************************************************************************************
void draw() 
{
  background(200);  
}

//**************************************************************************************
//
//**************************************************************************************
void actionPerformed (GUIEvent e) 
{
  if (e.getSource() == loadModuleButton) 
  {
    selectInput("Select a file to process:", "loadModuleButtonFileSelected");
  }
  else if (e.getSource() == saveModuleButton) 
  {
    selectInput("Select a file to process:", "saveModuleButtonFileSelected");
  }
}

//**************************************************************************************
//
//**************************************************************************************
void loadModuleButtonFileSelected(File selection) 
{
  if (selection != null) 
  {
    moduleBytes = loadBytes(selection.getAbsolutePath());
    Module m = new Module(moduleBytes);
    debugModule(m);
  }
}

//**************************************************************************************
//
//**************************************************************************************
void debugModule(Module mod)
{
  println("SongTitle:\t\t" + mod.getSongTitle());
  println("SongLength:\t" + mod.getSongLength());
  println("RestartByte:\t" + mod.getRestartByte());
  println("ModuleId:\t\t" + mod.getModuleId());

  /*
  for(int i = 0; i < mod.patternPlaySequence.length; i++)
  {
    print((mod.patternPlaySequence[i] & 0xff) + ", ");  
  }
  */

  for(int i = 0; i < mod.sampleDesciptions.length; i++)
  {
    ModuleSample sam = mod.sampleDesciptions[i];
    
    println("------------------------------------------------------------------");
    println("Sample" + i + ".SampleName:\t\t" + sam.getName());
    println("Sample" + i + ".sampleLength:\t" + sam.getLength());
    println("Sample" + i + ".Finetune:\t\t" + sam.getFinetune());
    println("Sample" + i + ".Volume:\t\t" + sam.getVolume());
    println("Sample" + i + ".loopStart:\t\t" + sam.getLoopStart());
    println("Sample" + i + ".loopLength:\t\t" + sam.getLoopLength());    
    println("------------------------------------------------------------------");
  }

  for(int i = 0; i < mod.patternData.length; i++)
  {
    ModulePattern pat = mod.patternData[i];
    
    println("------------------------------------------------------------------");

    for(int r = 0; r < pat.patternRows.length; r++)
    {
      ModulePatternRow row = pat.patternRows[r];
      println(
        "Pattern" + i + ".Row" + r + ":\t" +      
        hex(row.channelLeft) + "\t" +
        hex(row.channelMiddleLeft) + "\t" +
        hex(row.channelMiddleRight) + "\t" +
        hex(row.channelRight));
    }
    
    println("------------------------------------------------------------------");
  }
  
  println("sampleDataLength: " + mod.sampleData.length);    
}

//**************************************************************************************
//
//**************************************************************************************
void saveModuleButtonFileSelected(File selection) 
{
  if (selection != null)
  {
    if(moduleBytes != null)
    {
      println("User selected " + selection.getAbsolutePath());
    }    
  }
}