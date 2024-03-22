function add_user(){
        read -p "Enter user name: " name
        if [ grep "$name" bank.csv ]; then
                echo "User already exists"
        else
                echo "$name, 0$" >> bank.csv
        fi
}

function change_user_balance() {
        read -p "Enter user name:" name
        read -p "Enter balance:" amount
        awk -F',' -v name="$name" -v amount="$amount" 'BEGIN {OFS=", "} $1 ==name { $2 += amount } 1' bank.csv > temp.csv && mv temp.csv bank.csv
}

function delete_user() {
        read -p "Enter user to delete:" name
        awk -F',' -v name="$name" '$1 != name' bank.csv > temp.csv && mv temp.csv bank.csv
}

function display_users(){
        echo "Active users:"
        cat bank.csv
}

#If file doesn't exit, create
if [ ! -e bank.csv ]; then
        touch bank.csv
fi

if [ -e temp.csv ]; then
        touch temp.csv
fi

while true; do
        echo "****************************"
        echo "Choose option:"
        echo "1. Add user."
        echo "2. Change user balance."
        echo "3. Delete user."
        echo "4. Display all users."
         echo "5. Exit."
        echo "****************************"
        read -p "Enter option(1-5):" option

        case $option in
                1)
                        add_user
                        ;;
                2)
                        change_user_balance
                        ;;
                3)
                        delete_user
                        ;;
                4)
                        display_users
                        ;;
                5)
                        exit 0
                        ;;
                *)
                        echo "Invalid option. Only options from 1 to 5."
        esac
done
                                
