
//**************************************************************************************
//
//**************************************************************************************
class Module
{
  public byte[] songTitle;                    // Song title, padded with spaces
  public ModuleSample[] sampleDesciptions;      // Sample description record
  public byte songLength;                     // Song length in patterns (0-80h)
  public byte restartByte;                    // Restart byte for song looping (Noisetracker?)                      
  public byte[] patternPlaySequence;          // Pattern play sequences
  public byte[] moduleId;                     // ID='M.K.', ID='4CHN',ID='6CHN',ID='8CHN'
  public ModulePattern[] patternData;
  public byte[] sampleData;

  //**************************************************************************************
  //
  //**************************************************************************************
  Module (byte[] module)
  {
    setSongTitle(module);
    setSampleDesciptions(module);
    setSongLength(module);
    setRestartByte(module);
    setPatternPlaySequence(module);
    setModuleId(module);
    setPatternData(module); //<>// //<>//
    setSampleData(module); //<>// //<>//
  }

  //**************************************************************************************
  //
  //**************************************************************************************  
  void setSongTitle(byte[] module)
  {
    songTitle = new byte[20];
    arrayCopy(module, 0, songTitle, 0, 20);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  String getSongTitle()
  {
    return new String(songTitle);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************  
  void setSampleDesciptions(byte[] module)
  {
    sampleDesciptions = new ModuleSample[31];
    
    for(int i = 0; i < 31; i++)
    {
        sampleDesciptions[i] = new ModuleSample(module, i);
    }
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  ModuleSample[] getSampleDesciptions()
  {
    return sampleDesciptions;
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************    
  void setSongLength(byte[] module)
  {
    songLength = module[950];
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getSongLength()
  {
    return (songLength & 0xFF);
  }

  //**************************************************************************************
  //
  //**************************************************************************************  
  void setRestartByte(byte[] module)
  {
    restartByte = module[951]; 
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getRestartByte()
  {
    return (restartByte & 0xFF);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setPatternPlaySequence(byte[] module)
  {
    patternPlaySequence = new byte[128];    
    arrayCopy(module, 952, patternPlaySequence, 0, 128);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int[] getPatternPlaySequence()
  {
    int[] sequence = new int[patternPlaySequence.length];
    
    for(int i = 0; i < patternPlaySequence.length; i++)
    {
      sequence[i] = patternPlaySequence[i] & 0xFF;
    }
    
    return sequence;
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setModuleId(byte[] module)
  {
    moduleId = new byte[4];    
    arrayCopy(module, 1080, moduleId, 0, 4);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  String getModuleId()
  {
    return new String(moduleId);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setPatternData(byte[] module)
  {
    int maxPattern = getMaxPattern(module);   
    patternData = new ModulePattern[maxPattern];
    
    for(int i = 0; i < maxPattern; i++)
    {
      patternData[i] = new ModulePattern(module, i);
    }
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  ModulePattern[] getPatternData()
  {
    return patternData;
  }  
  
  //**************************************************************************************
  // 
  //**************************************************************************************
  void setSampleData(byte[] module)
  {
    int maxPattern = getMaxPattern(module);
    int sampleSize = 0;

    for(int i = 0; i < 31; i++)
    {
      sampleSize += sampleDesciptions[i].getLength() * 2;
    }
    
    int offset = 1084 + (1024 * (maxPattern + 1));

    sampleData = new byte[sampleSize];
    arrayCopy(module, offset, sampleData, 0, sampleSize); //<>// //<>//
  }
  
  //**************************************************************************************
  // 
  //**************************************************************************************
  byte[] getSampleData()
  {
    return sampleData;
  }
  
  //**************************************************************************************
  // 
  //**************************************************************************************
  int getMaxPattern(byte[] module)
  {
    int maxPattern = 0;
     
    for (int i = 0; i < 128; i++) 
    {
        int currentPattern = module[952 + i]  & 0xff;

        if (currentPattern > maxPattern)
        {
            maxPattern = currentPattern;
        }
    }
    
    return maxPattern;
  }
}