#!/bin/bash
cd Music
#----------------Author: Fahad Ansar-----------------
#----------------------------------File Organizer---------------------------
c=$'\n'
#----------------------------------backupArrays---------------------------
backUndo=()
backddo=()
#----------------------------------Formats to check----------------------
audio=("audio" "mp3 " "wav " "mid ")
video=("video" "mp4 " "wmv " "mov " " h264 " " 3gp " "avi " "mkv " "flv " "m4v " "3g2 " "mpg " "mpeg ")
docs=("xls " "ppt " "doc " "pdf " "txt " " xlsx " " pps " " pptx " " docx " " xml " "csv " "ods " "xlr ")
pic=("image" " jpg " "jpeg " " cr2 " "png " "gif " " bmp " "psd " " heic " " svg " "tif " "tiff " "xmp ")
sys=("system" " sys " " iso " " tmp " " bin " " dll " "dmg " " ttf " " bak " " cab " "cfg " "cpl " "cur " "dmp " " drv " " icns " " ico " "ini " " kkk " "msi " "toast " "vcd " " fnt " " fon " "otf ")
inter=("html " "css " " xhtml " " htm" " torrent " "cgi " " asp " " com " "cer " " cfm " " pl " " part " "rss ")
prog=("ascii " "c " " class " "cpp " " cs " " h " " java " " py" " swift " "js " "sh " "jsp " " php " "vb ")
compress=("compressed" " rar " "zip" " z " "7z " " arj " " deb " "pkg " " rpm " " gaz " "tar.gz " " tar " " gz ")
app=("executable" " exe " " jar " " apk " " bat " " gadget " " wsf ")
#-----------------------------reading the list of files from current directory
readarray files <<< $(ls)
#--------------------------------------------------Giving option to user for organization
read -p "Write number before one of the options below $c 1. Organize by type of file (Pictures, Documents, ..) $c 2. Organize by file format (jpg, docx, txt ..) - All files should have extentions $c" choice
#-----------------------------------------------Fix the duplication error
#------------------function to make and move folder after complete varification
action() {
  #---------------------------------- Local variables---------------------
  dirName=${1}
  filName=${2}
  #----------------------------------if file aready exist----------------
  if [ -f $dirName ]
  then
    dirName=$(echo "$dirName-")
  fi
  #----------------------------------if file already has been created-----
  if echo "${backUndo[@]}" | grep -q "$dirName"
  then
    hjkl=ll
  else
    mkdir ${dirName}
    echo "Folder created: $dirName"
    #----------------------------------adding it to the backup list------
    backUndo+=( "$dirName" )
  fi
  mv $filName $dirName
}
#-----------------------------------------------------------------
#----------------------------------Using method one (bytype)-------------
if [ $choice -eq 1 ]
then
  #---------------Method 1--------------
  #---changing the file seperator to new line '\n'
  OIFS=$IFS
  IFS=$'\n'
  #---for loop to go through all the files
  for(( i=0; i<${#files[@]}; i++ ))
  do
    #story filename in variables and applying file command
    f=${files[$i]}
    fil=$(file -b $f)
    fl=`echo $fil | tr '[A-Z]' '[a-z]'` #lowercase
    buskr=0                             #Bus krde
    #---checkign for directory
    if [[ $fl == *"directory"* ]]
    then
      continue
    fi
    j=$((i--))
    echo "-----------$j Done!------------------"
    echo "*To Process: $f"
    #---array to string
    k=$(printf "%s\n" "${audio[@]}")
    #---going thorugh that converted string
    for k in $k
    do
     if [[ $fl =~ "$k" ]]
      then
        action "audio" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #video
    k=$(printf "%s\n" "${video[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "video" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #Documents
    k=$(printf "%s\n" "${docs[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "documents" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #Pictures
    k=$(printf "%s\n" "${pic[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "pictures" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #system
    k=$(printf "%s\n" "${sys[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "system" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #internet
    k=$(printf "%s\n" "${inter[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "internet" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #programming
    k=$(printf "%s\n" "${prog[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "programming" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #compressed
    k=$(printf "%s\n" "${compress[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "compressed" "$f"
        buskr=1
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
    #app
    k=$(printf "%s\n" "${app[@]}")
    for k in $k
    do
      if [[ $fl =~ "$k" ]]
      then
        action "applications" "$f"
        buskr=1  # echo $kl
      # mv $x/* $kl
      fi
    done
    #---checking if baskrde was enabled
if [ $buskr -ne 0 ]; then continue; fi
  #if items matches none of above
  action "others" "$f"

  done
  IFS=OIFS                      #placing the value of IFS back
  # -------------------------------------
#-------------------------------------usign method two (byformat)-------
else
  # -------------Method 2----------------
  #---saving IFS value in a variable for storing back later
  OIFS=$IFS
  IFS=$'\n'
  #for loop to go through all the files
  for(( i=0; i<${#files[@]}; i++ ))
  do
      # storing filename into a varibale
      fk=${files[$i]}
      fil=$(echo ${fk##*.})
      #checkign if file already exist with similar name
      if [ -f "$fil" ]
      then
        fil=$(echo "$fil-")
      fi
      #using file command and storing it in a variable
      verf=$(file $fk)
      verfs=`echo $verf | tr '[A-Z]' '[a-z]'`
      #checking for directory
      if [[ $verfs == *"directory"* ]]
      then
        continue
      fi
      echo "To Process: $fk"
      #verifying with file command
      if echo "$verfs" | grep -q "$fil"
      then
          #checking if directory already exists
          if [ -d "$fil" ]
          then
            i=p
            backUndo+=( "$fil" )
          else
            mkdir ${fil}
            echo "Folder created: $fil"
            backUndo+=( "$fil" )
          fi
          #moving file
          mv $fk $fil
      else
        #checking if directory already exist
        if [ -d "others" ]
        then
          i=p
        else
          mkdir others
          echo "Folder created: others"
          backUndo+=( "others" )
        fi
          #moving file
          mv $fk others
      fi
  done
  IFS=OIFS              #storing the values back
  # --------------------------------------
fi
#*-------------------------End of central algorithm-------------------*#
#MsgsToPrint
echo "Shifting bits.."
echo "Just a sec, getting my coffee ready.."
echo "..."
echo "Items moved!"
echo "Complete!"
echo ""
#Undo_Option
read -p "Do you like the organization, If not press '1' to undo, else press any key... $c" mdkkr
#if user wants to undo
if [ $mdkkr -eq 1 ]
then
  kl=$PWD
  for x in "${backUndo[@]}"
  do
    mv $x/* $kl
    rm -r $x
  done
fi
echo "Its OK!, Not everyone has a good taste!"
echo "Complete!"
echo "Ignore errors!- Those are just to scare you!..."
echo "______________________________________________"
#---------------------------END------------------------------------------------
