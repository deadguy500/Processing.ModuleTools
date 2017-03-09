
//**************************************************************************************
//
//**************************************************************************************
class ModulePattern
{
  public ModulePatternRow[] patternRows;
  
  //**************************************************************************************
  // 
  //**************************************************************************************
  public ModulePattern(byte[] module, int patternNumber)
  {
    setPattern(module, patternNumber);
  }
  
  //**************************************************************************************
  // 
  //**************************************************************************************
  private void setPattern(byte[] module, int patternNumber)
  {
    patternRows = new ModulePatternRow[64];

    for(int i = 0; i < 64; i++)
    {
      patternRows[i] = new ModulePatternRow(module, patternNumber, i);
    }
  }
}