#include <stdio.h>
#include <stdlib.h>
#include "../TimeParser.h"

#ifndef MAX_INPUT
#define MAX_INPUT 100
#endif

int main(int argc, char **argv)
{
     char input[MAX_INPUT];
     double t;
     struct tm *str_time;

     while(1){
        printf("Give me a date in natural language ==> ");
        if (!fgets(input, MAX_INPUT, stdin)) {
             perror("an error occurred.\n");
        }

        t = parseDateTimeString(input);
        time_t finaltime = t;
        str_time= localtime(&finaltime);
        printf("The time = %s\n", asctime(str_time));        
    }
        return 0;
}