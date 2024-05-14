import java.sql.*;
import java.util.Scanner;


public class DBConnection {

    public static void main(String[] args) {

        String username = "ezrentadmin1";
        String password = "3ZRent@dm1n";

        String dbName = "ezrental";
        String hostname = "localhost";
        Connection conn = null;

        try (Scanner scanner = new Scanner(System.in)){

            //Building the connection string
            StringBuffer connectionString = new StringBuffer("jdbc:mysql://");
            connectionString.append(hostname + "/");
            connectionString.append(dbName);
            connectionString.append("?user=" + username);
            connectionString.append("&password=" + password);
            System.out.println("Connection String: " + connectionString.toString());

            //Try to open a connection to the database
            conn = DriverManager.getConnection(connectionString.toString());

            if (conn != null)
                System.out.println("Connected to DB: "+ dbName);

            boolean exit = false;

            while(!exit){
                // Display menu options
                System.out.println("--------------------------------------");
                System.out.println("EMPLOYEE PERFORMANCE MENU:");
                System.out.println("1. Show all employees");
                System.out.println("2. Search for a specific employee");
                System.out.println("3. Exit");
                System.out.println("--------------------------------------");
                System.out.print("Enter your choice 1-3: ");


                // Read user's choice
                int choice = scanner.nextInt();
                scanner.nextLine();

                switch (choice) {
                    case 1:
                        // Show all employees
                        showAllEmployees(conn);
                        break;
                    case 2:
                        // Search for a specific employee
                        searchEmployee(conn, scanner);
                        break;
                    case 3:
                        // Exit the program
                        exit = true;
                        System.out.println("Exiting program...");
                        break;
                    default:
                        System.out.println("Invalid choice. Please enter a number from 1 to 3.");
                }
            }



        } catch (Exception ex) {
            System.out.println("SQLException: " + ex.getMessage());
        }
        finally {
            try {
                //Closing the database connection
                if (conn != null) {
                    conn.close();
                    System.out.println("DB Connection Closed!");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static void showAllEmployees(Connection conn) throws SQLException{
        //Task 4: Display in the console all rows retrieved by the 'Employees_Performance' view
        String selectQuery = "SELECT * FROM Employees_Performance" ;
        Statement selectStatement = conn.createStatement() ;
        ResultSet rs = selectStatement.executeQuery(selectQuery);

        //print table headers
        System.out.printf("%-15s %-40s %-15s\n", "Employee No", "Employee Name", "Num Contracts");
        System.out.println("-----------------------------------------------------------------------");

        //process the results
        while(rs.next()){
            String employeeNo = rs.getString("Employee_No");
            String employeeName = rs.getString("Employee_Name");
            int numContracts = rs.getInt("NumContracts");
            System.out.printf("%-15s %-40s %-15d\n", employeeNo, employeeName, numContracts);
        }
    }

    private static void searchEmployee(Connection conn, Scanner scanner) throws SQLException{
        System.out.println("Enter Employee ID: ");
        String employeeID = scanner.nextLine();
        //Task 5: Display in the console all rows retrieved by the 'Employee ID'  in the Employees_Performance view
        String searchQuery = "SELECT * FROM Employees_Performance WHERE Employee_No = ?";
        PreparedStatement prepSearchStmt = conn.prepareStatement(searchQuery);
        prepSearchStmt.setString(1,employeeID);
        ResultSet searchResult = prepSearchStmt.executeQuery();


        // Check if any row is returned
        if (searchResult.next()) {

            String employeeNo = searchResult.getString("Employee_No");
            String employeeName = searchResult.getString("Employee_Name");
            int numContracts = searchResult.getInt("NumContracts");
            //print table headers
            System.out.printf("%-15s %-40s %-15s\n", "Employee No", "Employee Name", "Num Contracts");
            System.out.println("-----------------------------------------------------------------------");
            // Display the row associated with the provided Employee ID
            System.out.printf("%-15s %-40s %-15d\n", employeeNo, employeeName, numContracts);
            System.out.println();
        }else{
            System.out.println("Employee: " +employeeID+ " Not found in the Ezrental Database" );
        }
    }
}
