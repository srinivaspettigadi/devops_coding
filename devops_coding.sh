#/bin/sh
echo "Enter username"
read user_name
echo "Enter Password: "
read -s password
echo "enter repo name"
read repo_name
echo 
presentdate=`date +'%s'`
echo "prsent date is " $presentdate
pull_req_date=$(curl -s -u user_name:password https://api.github.com/repos/$user_name/$repo_name/pulls | jq '.[].updated_at' > out.txt)
echo $pull_req_date

for URL in `cat out.txt`;do
        thechar=$(echo $URL | cut -d'"' -f 2) 
        datein_sec=$(date -d $thechar +%s)
        echo date in sec $datein_sec
        numberofdays=$((($presentdate - $datein_sec)/(86400) ))
        echo numofdays final is $numberofdays 
        if [ $numberofdays -gt 3 ]
         then
        curl -X POST -H 'Content-type: application/json' --data '{"text":"'"$numberofdays"'"}' https://hooks.slack.com/services/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  
      else 
        echo "All the pull requests are good as of now" 
         fi     
done  
