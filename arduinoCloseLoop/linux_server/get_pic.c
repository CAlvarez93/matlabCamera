#include <iostream> 
#include <curl/curl.h> 
#include <stdio.h> 

using namespace std;

char url[] = "http://10.5.5.9:8080/video/DCIM/GOPR0100/";
char tempfile[] = "temp.JPG";

/*
 * Usage: ./get_pic <integer> <photoname>
 */
int main()
{ 
  CURL *image; 
  CURLcode imgresult; 
  FILE *fp = NULL; 

  int imgNo = (int) strtol(argv[1], (char **)NULL, 10);
  char nFile[] = strcat(argv[1], ".JPG");

  image = curl_easy_init(); 
  if( image ){ 
    // Open file
    execve("/bin/cp/", tempfile, nFile);
    fp = fopen(nFile, "wb"); 
    if( fp == NULL ) cout << "File cannot be opened"; 

    // construct image url
    char imgFn[] = strcat(argv[2], ".JPG");
    char imgUrl[] = strcat(url, imgFn);
    
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
  return 0; 
}
