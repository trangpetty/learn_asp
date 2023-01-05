<!-- #include file="connect_200164.asp" -->
<%
    If (Session("email")="") Then
        Response.redirect("login_200164.asp")
    End If
    If (Request.ServerVariables("Request_Method") = "GET") Then
        id = Request.QueryString("id")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if
        If (cint(id) <> 0) Then

            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT * FROM users WHERE id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                name = Result("name")
                email = Result("email")
                password = Result("password")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        name = Request.form("name")
        email = Request.form("email")
        password = Request.form("password")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(name) and (name<>"")) and (NOT isnull(email) and (email<>"")) and (NOT isnull(password) and (password<>"")) Then
                'strSQL="INSERT INTO users(name,email,password) values ('" & name & "','" & email & "','" & password & "')"
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO users(name,email,password) values (?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name", 202, 1, 50, name)
                cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 200, password)
                cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 200, email)
            
                cmdPrep.execute

                Session("Success")="Add a new user successfully"
                Response.redirect("admin_200164.asp")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(name) and (name<>"")) and (NOT isnull(email) and (email<>"")) and (NOT isnull(password) and (password<>"")) Then
                'strSQL="UPDATE user Set name='" & name &"',email='" & email & "', password='" & password &"' WHERE id=" & id
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE users Set name=?,email=?,password=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("name", 202, 1, 50, name)
                cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 200, email)
                cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 200, password)
                cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
                cmdPrep.execute

                Session("Success")="Edit  successfully"
                Response.redirect("admin_200164.asp")
            Else
                Session("Error")="You have to input info"
            End if            
        End if
    End if
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>CRUD Example</title>
    </head>
    <body>
        <!-- #include file="header_admin_200164.asp" -->

        <div class="container">
            <form method="post" action="addedit_user_200164.asp">
                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input type="text" class="form-control" id="name" name="name" value="<%=name%>">
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="text" class="form-control" id="password" name="password" value="<%=password%>">
                </div>
                <div class="row">
                    <div class="form-group">
                        <input type="hidden" name="id" id="id" value="<%=id%>">
                        <button type="submit" class="btn btn-primary">
                            <%
                                if (id=0) then
                                    Response.write("Create")
                                else
                                    Response.write("Edit")
                                end if
                            %>
                        </button>
                        <a href="admin_200164.asp" class="btn btn-info">Cancel</a>
                    </div>
                </div>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>