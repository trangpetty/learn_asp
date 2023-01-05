<!-- #include file="connect_200164.asp" -->
<%
    If (Session("email")="") Then
        Response.redirect("login.asp")
    End If
    If (Request.ServerVariables("Request_Method") = "GET") Then
        id = Request.QueryString("id")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if
        If (cint(id) <> 0) Then

            Set cmdPrep = Server.CreateObject("ADODB.Command")
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "SELECT * FROM books WHERE id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                author = Result("author")
                description = Result("description")
                quanity = Result("quanity")
                user_id = Result("user_id")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        author = Request.form("author")
        description = Request.form("description")
        user_id = Request.form("user_id")
        quanity = Request.form("quanity")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(author) and (author<>"")) and (NOT isnull(description) and (description<>"")) and (NOT isnull(quanity) and (quanity<>"")) and (NOT isnull(user_id) and (user_id<>"")) Then
                'strSQL="INSERT INTO books(author,description,quanity,user_id) values ('" & author & "','" & description & "','" & quanity & "','" & user_id & "')"
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO books(author,description,quanity,user_id) values (?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("author", 202, 1, 200, author)
                cmdPrep.parameters.Append cmdPrep.createParameter("description", 202, 1, 200, description)
                cmdPrep.parameters.Append cmdPrep.createParameter("quanity", 202, 1, 200, quanity)
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 200, user_id)
            
                cmdPrep.execute

                Session("Success")="Add a new book successfully"
                Response.redirect("admin_200164.asp")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(author) and (author<>"")) and (NOT isnull(description) and (description<>"")) and (NOT isnull(quanity) and (quanity<>"")) and (NOT isnull(user_id) and (user_id<>"")) Then
                'strSQL="UPDATE books Set author='" & author &"',description='" & description & "', quanity='" & quanity &"', user_id='" & user_id &"' WHERE id=" & id
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE books Set author=?,description=?,quanity=?,user_id=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("author", 202, 1, 200, author)
                cmdPrep.parameters.Append cmdPrep.createParameter("description", 202, 1, 200, description)
                cmdPrep.parameters.Append cmdPrep.createParameter("quanity", 202, 1, 200, quanity)
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 200, user_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))            
                cmdPrep.execute

                Session("Success")="Edit successfully"
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
        <title>Trang 200164</title>
    </head>
    <body>
        <!-- #include file="header_admin_200164.asp" -->

        <div class="container">
            <form method="post" action="addedit_book_200164.asp">
                <div class="mb-3">
                    <label for="author" class="form-label">Author</label>
                    <input type="text" class="form-control" id="author" name="author" value="<%=author%>">
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <input type="text" class="form-control" id="description" name="description" value="<%=description%>">
                </div>
                <div class="mb-3">
                    <label for="user_id" class="form-label">Quanity</label>
                    <input type="number" class="form-control" id="quanity" name="quanity" value="<%=quanity%>">
                </div>
                <div class="mb-3">
                    <label for="user_id" class="form-label">User ID</label>
                    <input type="number" class="form-control" id="user_id" name="user_id" value="<%=user_id%>">
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