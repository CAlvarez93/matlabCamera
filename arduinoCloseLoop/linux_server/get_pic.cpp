#include <iostream> 
#include <curl/curl.h> 
#include <stdio.h> 
#include <unistd.h>

using namespace std;

char url[] = "http://10.5.5.9:8080/videos/DCIM/100GOPRO//";
char tempfile[] = "temp.JPG";

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
  int i;
  for (i=1; i<=argc; i++)
  {
    CURL *image; 
    CURLcode imgresult; 
    FILE *fp = NULL;



    int imgNo = i;
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
      char *imgFn = (char *) malloc((4 + strlen(argv[i])) * sizeof(char));
      imgFn = strcat(argv[i], ".JPG");

      char *imgUrl = (char *) malloc((strlen(url) + strlen(imgFn)) * sizeof(char));
      imgUrl = strcat(url, imgFn);
    
      // fetch image
      curl_easy_setopt(image, CURLOPT_URL, imgUrl); 
      curl_easy_setopt(image, CURLOPT_WRITEFUNCTION, NULL); 
      curl_easy_setopt(image, CURLOPT_WRITEDATA, fp); 


      // Grab image 
      imgresult = curl_easy_perform(image); 
      if( imgresult ){ 
          cout << "Cannot grab the image!\n"; 
      } 
    } 

    // Clean up the resources 
    curl_easy_cleanup(image); 
    // Close the file 
    fclose(fp); 

  }
  return 0; 
}
