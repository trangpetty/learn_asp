<!-- #include file="connect_200164.asp" -->
<%
    If (Not isnull(Session("email"))) AND (Trim(Session("email"))<>"") Then
        Response.redirect("/user_200164.asp")
    End If
    email = Request.form("email")
    password = Request.form("password")
    If (NOT isnull(email) AND Trim(email)<>"") AND (NOT isnull(password) AND Trim(password)<>"") Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT * FROM users WHERE email=? AND password=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("email", 202, 1, 255, email)
            cmdPrep.parameters.Append cmdPrep.createParameter("password", 202, 1, 255, password)
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                email=Result("email")
                Session("email")=email
                Session("Success")="Login successfully"
                Session("role")=Result("role")
                If (NOT isnull(Session("CurrentPage"))) AND (TRIM(Session("CurrentPage"))<>"") Then
                    Response.redirect(Session("CurrentPage"))
                    Session.Contents.Remove("CurrentPage")
                Else
                    If Session("role") = 1 Then
                        Response.redirect("admin_200164.asp")
                    Else Response.redirect("user_200164.asp")
                    End If
                End If
            Else
                Session("Error")="Wrong email or password"
            End if
    Else
        If (Request.ServerVariables("Request_Method") = "POST") Then
            Session("Error") = "You need to input information"
        End If
    End If
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-F3w7mX95PdgyTmZZMECAngseQB83DfGTowi0iMjiWaeVhAn4FJkqJByhZMI3AhiU" crossorigin="anonymous">
        <title>Login</title>
    </head>
    <body>

        <!-- #include file="header_200164.asp" -->
        <div class="container">
            <form method="post" action="login_200164.asp">
                <div class="mb-3">
                    <label for="name" class="form-label">Email</label>
                    <input type="text" class="form-control" id="email" name="email" value="<%=email%>">
                </div>
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password">
                </div>
                <button type="submit" class="btn btn-success">Login</button>
            </form>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    </body>
</html>