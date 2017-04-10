#include <stdio.h>

int main(int argc, char *argv[])
{
    unsigned short byte = 0x5a, index, test, gen = 0x1021;
    unsigned short crc = 0;

    crc = byte;

    for (index = 0; index <= 15; index++)
    {
        test = crc & 0x8000; //hex mask for 1000000000000000
        crc = crc << 1;
        if(test) //if the position im testing is 1, do XOR
        {
            crc = crc^gen;
        }
    }
    
    printf("0x%x\n", crc);

    return 0;
}