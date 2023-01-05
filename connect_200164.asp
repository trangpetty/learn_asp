<%
    Set connDB = Server.CreateObject("ADODB.Connection")

    strConnection = "Provider=SQLOLEDB; Initial Catalog=THICK;User id=sa; Password=123"

    connDB.ConnectionString = strConnection
    connDB.Open
%>