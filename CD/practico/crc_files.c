#include <stdio.h>
#define OUTPUT "output"

int main(int argc, char *argv[])
{
    if (argc >= 2)
    {
        FILE *fp, *op; //pointer to files
        char c;   //file content char by char
        unsigned short test, msbletra, crc = 0;

        fp = fopen(argv[1], "r");
        op = fopen(OUTPUT, "a");
        
        while (1)
        {
            c = fgetc(fp);
            if (feof(fp))
            {
                break;
            }
            for (int i = 0; i < 8; i++) //calculo el crc para cada letra del archivo y lo acumulo
            {
                msbletra = (c & 0x80) >> 7; //creo un char que funciona como un bit
                c = c << 1;
                test = crc & 0x8000;
                crc = crc << 1;
                crc += msbletra;
                if (test)
                    crc = crc ^ 0x1021;
            }
        }

        for (int j = 0; j < 16; j++) //agrego los 16 ceros
        {
            test = crc & 0x8000;
            crc = crc << 1;
            if (test)
                crc = crc ^ 0x1021;
        }

        fwrite(&crc, sizeof(crc), 1, op);
        printf("%x\n", crc);
        fclose(fp);
        fclose(op);
    }
    else
    {
        printf("Filename not supplied\n");
        return 1;
    }
    return 0;
}