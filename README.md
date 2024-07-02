# Automating User and Group Management with Bash Scripts

**Overview**

This bash script automates the process of creating, deleting, and modifying users and groups on a Linux system. This script is designed to be run from the command line and takes user input to determine which action to perform.

Needed Files;

```
create_users.sh
```

```
`users.txt`
```

- `create_users.sh` is the main script that reads the `users.txt` file and creates users and groups based on the information provided in the file.

- `users.txt` is a sample input file that contains the list of users and their groups. Each line in the file contains the username and group name separated by a space.

**Usage**

To use the script, simply run the `create_user.sh` file from the command line. The script will prompt you to select an action to perform and then guide you through the process of completing that action.

**Example Usage**

To create a new user, run the following command:

```bash
./create_user.sh
```

The script will prompt you to enter the username, password, and group for the new user. Once you have entered the required information, the script will create the user and display a success message.

**Conclusion**

This script provides a simple and efficient way to manage users and groups on a Linux system. By automating the process, you can save time and reduce the risk of errors when performing these tasks.

**Learn More About HNG Internship**

To learn more about the HNG Internship program, visit the [HNG Tech website](https://hng.tech/).
