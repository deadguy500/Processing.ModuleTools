
//**************************************************************************************
//
//**************************************************************************************
public class ModuleSample
{
  public byte[] name;                  // Sample name, padded with zeroes to full length.    
  public byte[] length;                // Sample length / 2 (max 8000h)
  public byte finetune;                // Sample finetune. Only the lower nibble is valid  
  public byte volume;                  // Sample volume (0-40h)
  public byte[] loopStart;             // Sample loop start / 2
  public byte[] loopLength;            // Sample loop length / 2
  
  public ModuleSample(byte[] module, int sampleNumber)
  {
    setName(module, sampleNumber);
    setLength(module, sampleNumber);
    setFinetune(module, sampleNumber);
    setVolume(module, sampleNumber);
    setLoopStart(module, sampleNumber);   
    setLoopLength(module, sampleNumber);  
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************  
  void setName(byte[] module, int sampleNumber)
  {
      name = new byte[22];
      int offset = 20 + (30 * sampleNumber);  
      arrayCopy(module, offset, name, 0, 22);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  String getName()
  {
    return new String(name);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setLength(byte[] module, int sampleNumber)
  {
    length = new byte[2];
    int offset = 20 + (30 * sampleNumber) + 22;
    arrayCopy(module, offset, length, 0, 2);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getLength()
  {
    return ((length[0] & 0xFF) << 8) | (length[1] & 0xFF);
  }  
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setFinetune(byte[] module, int sampleNumber)
  {
    int offset = 20 + (30 * sampleNumber) + 24;
    finetune =  module[offset];
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getFinetune()
  {
    return (finetune & 0xFF);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setVolume(byte[] module, int sample_number)
  {
    int offset = 20 + (30 * sample_number) + 25;  
    volume = module[offset];
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getVolume()
  {
    return (volume & 0xFF);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setLoopStart(byte[] module, int sampleNumber)
  {
    loopStart = new byte[2];
    int offset = 20 + (30 * sampleNumber) + 26;  
    arrayCopy(module, offset, loopStart, 0, 2);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getLoopStart()
  {
    return ((loopStart[0] & 0xFF) << 8) | (loopStart[1] & 0xFF);
  }  
  
  //**************************************************************************************
  //
  //**************************************************************************************
  void setLoopLength(byte[] module, int sampleNumber)
  {
    loopLength = new byte[2];
    int offset = 20 + (30 * sampleNumber) + 28;    
    arrayCopy(module, offset, loopLength, 0, 2);
  }
  
  //**************************************************************************************
  //
  //**************************************************************************************
  int getLoopLength()
  {
    return ((loopLength[0] & 0xFF) << 8) | (loopLength[1] & 0xFF);
  }  
}