# sql
sql examples

## SSDT
### How to add SqlCmdVariable in sqlproj file
The following example shows how to add SqlCmdVariable that are set on values stored in Data-tier Application properties.   

```
  <ItemGroup>
    <SqlCmdVariable Include="SqlDacName">
      <DefaultValue>DefaultName</DefaultValue>
      <Value>$(Name)</Value>
    </SqlCmdVariable>
    <SqlCmdVariable Include="SqlDacVersion">
      <DefaultValue>DefaultVersion</DefaultValue>
      <Value>$(DacVersion)</Value>
    </SqlCmdVariable>
  </ItemGroup>
```

In this example two *sql cmd variables* are created: SqlDacName, SqlDacVersion. They are set on values taken from sqlproj properties:

```
<PropertyGroup>
    <Name>SSDT1</Name>
    <DacVersion>1.0.0.0</DacVersion>
    ...
</PropertyGroup>
```

Adding *sql cmd variables* causes that they will be displayed in publish dialog in Visual Studio. Click on *Load Values* will cause that
the variables will be set on values for the pointed sqlproj properties.   
Next the *sql cmd variables* can be use in sql files, for example:   

```
insert into [Schema1].[Versions] 
([Id], [DacName], [DacVersion], [DateTimeUtc], [Action])
values (1, N'$(SqlDacName)', N'$(SqlDacVersion)', GETUTCDATE(), N'PostDeploy');
```   
### How to reference between *sqlproj* files
In order to reference one *sqlproj* in another *sqlproj* a *database reference* has to be added.   

#### Publish order
In case SSDT2 has reference to SSDT1 then publish of SSDT2 first will execute publish of SSDT1. The mechanism checks reference tree. Publication on root *sqlproj* will start publish from the leaves *sqlprojs* up to the root *sqlproj*.   

NOTE: there is one drawback in this mechanism. Pre-deployment and pos-deployment scripts from the referenced projects are not executed!.
Workaround is to reference them in the pre-deployment and pos-deployment directly using *:r* syntax.

```
:r ..\..\SSDT1\Scripts\Script.PreDeployment.sql
```   
The path starts from the file in which *:r* is used.
To avoid misleadining errors in VS *SQLCMD* mode has to be enabled.

![sqlcmd mode](.\screens\enableSQLCMDmode.png)

#### Reference to dacpac

#### SSDT in nugets