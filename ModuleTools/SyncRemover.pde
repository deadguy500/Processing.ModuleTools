
//**************************************************************************************
//
//**************************************************************************************
void removeSyncCommands()
{
  int maxPattern = 0;
  
  for(int i = 0; i < 128; i++)
  {
    if(module.patternPlaySequence[i] > maxPattern)
    {
      maxPattern = module.patternPlaySequence[i];
    }
  }

  for(int p = 0; p <= maxPattern; p++)
  {
    for(int r = 0; r < 64; r++)
    {
      module.patternData[p].patternRows[r].channelLeft = removeSync(module.patternData[p].patternRows[r].channelLeft);
      module.patternData[p].patternRows[r].channelMiddleLeft = removeSync(module.patternData[p].patternRows[r].channelMiddleLeft);
      module.patternData[p].patternRows[r].channelMiddleRight = removeSync(module.patternData[p].patternRows[r].channelMiddleRight);
      module.patternData[p].patternRows[r].channelRight = removeSync(module.patternData[p].patternRows[r].channelRight);
    }
  }
}

//**************************************************************************************
//
//**************************************************************************************
int removeSync(int channelData)
{
  if ((channelData & 0x00000F00) == 0x800)
  {
    return channelData & 0xFFFFF000;
  }
  else if((channelData & 0x00000FF0) == 0xE80)
  {
    return channelData & 0xFFFFF000;
  }
  
  return channelData;
}