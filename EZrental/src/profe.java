import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class profe {

    public static void main(String[] args)
    {
        //String username = "cop4710-admin";
        //String password = "COP4710@dm1n";

        String username = "ezrentadmin1";
        String password = "3ZRent@dm1n";

        String dbName = "ezrental";
        String hostname = "localhost";
        Connection conn = null;
        try {

            //Building the connection string
            StringBuffer connectionString = new StringBuffer("jdbc:mysql://");
            connectionString.append(hostname+"/");
            connectionString.append(dbName);
            connectionString.append("?user="+username);
            connectionString.append("&password="+password);
            System.out.println("Connection String: "+connectionString.toString());

            //Try to open a connection to the database
            conn = DriverManager.getConnection(connectionString.toString());

            if(conn != null)
                System.out.println("Connected to DB !!");

            String selectQuery = "SELECT FName, LName FROM Student WHERE Major = ?" ;
            PreparedStatement prepSelectStmt = conn.prepareStatement(selectQuery) ;
            prepSelectStmt.setString(1,"Psychology");

            ResultSet rs = prepSelectStmt.executeQuery();

            while(rs.next()) {
                System.out.println(rs.getString("FName")+" "+rs.getString("LName"));
            }

            String updateQuery= "UPDATE Student SET Major = ? WHERE Sid = ?" ;
            PreparedStatement prepUpdateStmt = conn.prepareStatement(updateQuery) ;
            prepUpdateStmt.setString(1,"Computer Science");
            prepUpdateStmt.setString(2,"4400694");

            int rows = prepUpdateStmt.executeUpdate();
            System.out.println("Number of rows affected: "+rows);
        }
        catch (Exception ex)
        {
            System.out.println("SQLException: " + ex.getMessage());
        }
        finally {
            try {
                //Closing the database connection
                if(conn != null) {
                    conn.close();
                    System.out.println("Connected is closed!!");
                }
            }
            catch (SQLException e) { e.printStackTrace();
            }

        }
    }

}
