
//**************************************************************************************
//
//**************************************************************************************
public class ModulePatternRow
{
  public int channelLeft;        // TODO, bytes
  public int channelMiddleLeft;  // TODO, bytes
  public int channelMiddleRight; // TODO, bytes
  public int channelRight;       // TODO, bytes
  
  public ModulePatternRow(byte[] module, int patternNumber, int rowNumber)
  {
    setPatternRow(module, patternNumber, rowNumber);
  }
  
  private void setPatternRow(byte[] module, int patternNumber, int rowNumber)
  {
    byte[] rowData = new byte[16];
    
    int patternOffset = 1084 + (1024 * patternNumber) + (16 * rowNumber);

    arrayCopy(module, patternOffset, rowData, 0, 16);  

    channelLeft = rowData[0] << 24 | rowData[1] << 16 | rowData[2] << 8 | rowData[3];
    channelMiddleLeft = rowData[4] << 24 | rowData[5] << 16 | rowData[6] << 8 | rowData[7];
    channelMiddleRight = rowData[8] << 24 | rowData[9] << 16 | rowData[10] << 8 | rowData[11];
    channelRight = rowData[12] << 24 | rowData[13] << 16 | rowData[14] << 8 | rowData[15];
  }
}