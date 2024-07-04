#include <ultra64.h>

static u64 buffer;

static void flashrom_wr(u32 addr, u32 data)
{
    OSIoMesg mb;
    OSMesgQueue mq;
    OSMesg mbox[1];
    osCreateMesgQueue(&mq, mbox, 1);
    buffer = (u64)data << 48;
    osWritebackDCache(&buffer, 8);
    osPiStartDma(&mb, OS_MESG_PRI_NORMAL, OS_WRITE, addr, &buffer, 2, &mq);
    osRecvMesg(&mq, NULL, OS_MESG_BLOCK);
}

int flashrom_detect(void)
{
    return;
    /*
    int i;
    u32 x, y;
    osPiReadIo(0, &y);
    flashrom_wr(0xAAA, 0xAA);
    flashrom_wr(0x554, 0x55);
    flashrom_wr(0xAAA, 0x90);
    osPiReadIo(0, &x);
    if (x == y) return 0;
    switch (x & 0xFFFF)
    {
    case 0x227E:
    case 0x22C9:
    case 0x22CB:
    flashrom_wr(0, 0xF0);
    return 1;
    break;
    case 0x8816:
    for (i = 0; i < 256; i++) flashrom_wr(0x20000*i, 0xFF);
    return 1;
    break;
    }
    flashrom_wr(0xAAA, 0xAAAA);
    flashrom_wr(0x554, 0x5555);
    flashrom_wr(0xAAA, 0x9090);
    osPiReadIo(0, &x);
    if (x == y) return 0;
    switch (x & 0xFFFF)
    {
    case 0x7E7E:
    flashrom_wr(0, 0xF0F0);
    return 1;
    break;
    }
    return -1;
    */
}