#!/bin/bash                                                                                                                                                                            
                                                                                                                                                                                       
if [ $# -eq 0 ]                                                                                                                                                                        
then                                                                                                                                                                                   
echo "usage : ./SubFind.sh  <URL>"                                                                                                                                                     
echo "ex : ./SubFind.sh https://www.google.com/"                                                                                                                                       
else                                                                                                                                                                                   
z=$(echo $1 | cut -d "." -f 2- | cut -d "/" -f 1)                                                                                                                                      
wget -U 'Mozilla/5.0' -O index.html "$1"                                                                                                                                               
cat index.html | grep -i -o "[a-z0-9]*.$z" | sort -u > sub_tmp.txt                                                                                                                     
                                                                                                                                                                                       
                                                                                                                                                                                       
for x in $(cat sub_tmp.txt)                                                                                                                                                            
do                                                                                                                                                                                     
if [[ $(ping -c 1 $x 2> /dev/null) ]]                                                                                                                                                  
then                                                                                                                                                                                   
echo "[+] valid >> $x"                                                                                                                                                                 
echo $x >> sub.txt                                                                                                                                                                     
rm -rf sub_tmp.txt                                                                                                                                                                     
else                                                                                                                                                                                   
echo "[-] error >> $x"                                                                                                                                                                 
fi                                                                                                                                                                                     
done                                                                                                                                                                                   
                                                                                                                                                                                       
                                                                                                                                                                                       
for i in $(cat sub.txt)                                                                                                                                                                
do                                                                                                                                                                                     
ping -c 1 -W 1 $i | cut -d "(" -f2- | cut -d ")" -f1 | cut -d " " -f12                                                                                                                 
ping -c 1 -W 1 $i | cut -d "(" -f2- | cut -d ")" -f1 | cut -d " " -f12  >> ips_tmp.txt                                                                                                 
done                                                                                                                                                                                   
sort -u ips_tmp.txt > ips.txt                                                                                                                                                          
rm -rf ips_tmp.txt                                                                                                                                                                     
rm -rf index.html                                                                                                                                                                      
                                                                                                                                                                                       
clear                                                                                                                                                                                  
echo "total valid subdomain : $(wc -l < sub.txt)"                                                                                                                                      
echo "total valid ip : $(wc -l < ips.txt)"                                                                                                                                             
echo "Done ... [+] Just write ls for show files & results. "                                                                                                                           
fi
