CREATE SCHEMA university_COP4710_1241;

USE university_COP4710_1241;

create table college(
    CName varchar(100) PRIMARY KEY,
    COfice varchar(50),
    CPhone varchar(20),
    Dean varchar(20)
    );
    
    create table department(
    DCode varchar(50) PRIMARY KEY,
    DName varchar(100) UNIQUE NOT NULL,
    DOffice varchar(50),
    DPhone varchar(20),
    Chair varchar(20) NOT NULL, 
    CStarDate datetime NOT NULL
    );
   
    create table instructor(
    ID varchar(20) PRIMARY KEY,
    IName varchar(100) NOT NULL,
    IOffice varchar(50),
    IPhone varchar(20),
    IRank enum('Adjunct', 'Faculty', 'Tenure'),
    Department varchar(50) NOT NULL,
    foreign key (department) references department(DCode) on update cascade
    );
    
    alter table college add constraint dean_fk_1 foreign key (Dean) references instructor(ID) ON UPDATE cascade;
    
    alter table department add constraint chair_fk_1 foreign key (Chair) references instructor(ID) ON UPDATE cascade;
    
    create table course(
    CCode varchar(10) PRIMARY KEY,
    CoName varchar(100) UNIQUE NOT NULL,
    Level enum('Freshman', 'Sophomore', 'Junior', 'Sinior', 'Grad', 'Non-Credit') NOT NULL,
    Credits smallint,
    CDesc varchar(200), 
    Department varchar(50) NOT NULL,
    foreign key (Department) references department(DCode) on update cascade
    );
    
    create table semester(
    Code char(4) PRIMARY KEY,
    Name varchar(50),
    Star_Date datetime not null,
    End_Date datetime not null
    );
    
    create table section(
    Course varchar(10), 
    SectID varchar(10),
    DaysTime varchar(50),
    Bldg varchar(10),
    RoomNo varchar(10),
    Instructor varchar(20) NOT NULL,
    Semester char(4),
    PRIMARY KEY (Course, SectID),
    foreign key(Course) references course(CCode) on update cascade,
    foreign key(Instructor) references instructor(ID) on update cascade,
    foreign key(Semester) references semester(Code) on update cascade
    );
    
    create table student(
    Sid varchar(10) primary key,
    Fname varchar(100),
    Mname varchar(100),
    Lname varchar(100),
    Addr varchar(100),
    DoB datetime not null,
    Major varchar(100),
    Phone varchar(20),
    Department varchar(50) not null,
    foreign key (Department) references department(DCode) on update cascade
    );
    
    
    create table enrollment(
    student varchar(10),
    section varchar(10),
    course varchar(10),
    grade enum('A', 'B', 'C', 'D', 'F'),
    primary key(student, section, course),
    foreign key(student) references student(Sid) on update cascade,
    foreign key(course, section) references section(Course, SectID) 
    );
    
    drop table Name /*delete tables*/
    