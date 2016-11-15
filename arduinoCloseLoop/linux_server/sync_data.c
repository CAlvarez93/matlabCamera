#include <stdio.h> 
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
 * Usage: ./sync_data <filename>*
 */
int main(int argc, char **argv)
{
  int i = 0;
  char *line = NULL;
  size_t len = 0;
  ssize_t read;

  char fList[100][30];

  FILE *ld;
  ld = fopen("ld.csv", "wb"); 
  if( ld == NULL ) printf("File cannot be opened");

  FILE *fp;
  fp = fopen("lidar_data.csv", "r");
  if( fp == NULL ) printf("File cannot be opened");

  FILE *list;
  list = fopen("jpg_list", "r");
  if( list == NULL ) printf("File cannot be opened");
  int k = 0;
  while ((read = getline(&line, &len, list)) != -1)
  { 
    if(strcmp("temp.JPG", line) != 0) 
    {
      strcpy( fList[k++], line );
    }
  }

  k = 0;

  int j = 0;
  while ((read = getline(&line, &len, fp)) != -1)
  { 
    if(j==0){j=1; continue;} // skip first line

    char buf[30];
    line[strlen(line) - 1] = 0;
    strcpy(buf, line);
    strcat(buf, ",");
    strcat(buf, fList[k++]);
    fputs(buf, ld);
    i++;
  }

  fclose(ld);
  fclose(fp);
  return 0; 
}
