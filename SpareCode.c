void SpareCode()
{
     loadFont();
     GlobalIntB = 5;
     for(int This = 0; This < 48; This +=3)
     {
          printStringUnsignedHex(0,GlobalIntB, "", *(int*)(0x80700000 + (This * 4)));
          printStringUnsignedHex(75,GlobalIntB, "", *(int*)(0x80700000 + ((This + 1) * 4)));
          printStringUnsignedHex(150,GlobalIntB, "", *(int*)(0x80700000 + ((This + 2) * 4)));
          GlobalIntB += 10;
     }

}