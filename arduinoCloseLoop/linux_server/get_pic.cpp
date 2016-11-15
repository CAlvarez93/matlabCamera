#include <iostream> 
#include <curl/curl.h> 
#include <stdio.h> 
#include <unistd.h>
#include <fstream>
#include <sstream>
#include <string>
#include <stdlib.h>
#include <stdio.h>

using namespace std;

char url[] = "http://10.5.5.9:8080/videos/DCIM/100GOPRO/";
char tempfile[] = "temp.JPG";
char imgList[] = "imglist.txt";
//char imgList[] = "imglist2.txt";
/*
 * int to string
 */ 
char * intToStr(int in){
  char str[30];
  sprintf(str, "%d", in);
  char *out = (char*) malloc(strlen(str) * sizeof(char));
  strcpy(out, str);
  return out; 
}

/*
 * Usage: ./get_pic <photoname>*
 */
int main(int argc, char **argv)
{ 
  int imgNo = 1;
  CURL *image; 
  CURLcode imgresult; 
  FILE *fp;
  FILE *imgFp;
  char *imgUrl = (char *) malloc((strlen(url) + 12) * sizeof(char));

  char *line = NULL;
  size_t len = 0;
  ssize_t read;

  imgFp = fopen(imgList, "r");
  if (imgFp == NULL) cout << "File cannot be opened: imglist.txt";
  
  while ((read = getline(&line, &len, imgFp)) != -1)
  {
//cout << line;

    image = (CURL *) NULL; 
    imgresult = (CURLcode) NULL; 
    fp = NULL;


    char *nFile = (char *) malloc((4 + imgNo) * sizeof(char));
    nFile = intToStr(imgNo);
    nFile = strcat(nFile, ".JPG");

    image = curl_easy_init(); 
    if( image ){ 
      // Open file
      execl("/bin/cp/", "cp", tempfile, nFile, NULL);
      fp = fopen(nFile, "wb"); 
      if( fp == NULL ) cout << "File cannot be opened"; 

      // construct image url
      strcpy(imgUrl, url);
      strcat(imgUrl, line);
      imgUrl[strlen(imgUrl) - 1] = 0;

//cout << imgUrl;  

      // fetch image
      curl_easy_setopt(image, CURLOPT_URL, imgUrl); 
      curl_easy_setopt(image, CURLOPT_WRITEFUNCTION, NULL); 
      curl_easy_setopt(image, CURLOPT_WRITEDATA, fp);

      // Grab image 
      imgresult = curl_easy_perform(image); 
      if( imgresult ){ 
          cout << "Cannot grab the image!\n"; 
        //cout << "";
      } 
    } 

    // Clean up the resources 
    curl_easy_cleanup(image); 
    // Close the file 
    fclose(fp); 
    imgNo++;
  }
  return 0; 
}
