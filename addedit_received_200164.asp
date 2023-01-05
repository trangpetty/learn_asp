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
            cmdPrep.CommandText = "SELECT * FROM received_notes WHERE id=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("id", 3, 1, , cint(id))
            
            Set Result = cmdPrep.execute

            if not Result.EOF then
                book_id = Result("book_id")
                user_id = Result("user_id")
                created_date = Result("created_date")
            End If

            Set Result = Nothing
        End If
    Else
        id = Request.form("id")
        book_id = Request.form("book_id")
        user_id = Request.form("user_id")
        created_date = Request.form("created_date")

        If (trim(id) = "") or (isnull(id)) then id = 0 end if

        if cint(id) = 0 then

            If (NOT isnull(book_id) and (book_id<>"")) and (NOT isnull(user_id) and (user_id<>"")) and (NOT isnull(created_date) and (created_date<>"")) Then
                'strSQL="INSERT INTO books(book_id,user_id,created_date,user_id) values ('" & book_id & "','" & user_id & "','" & created_date & "')"
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO books(book_id,user_id,created_date) values (?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("book_id", 202, 1, 200, book_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 200, user_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("created_date", 202, 1, 200, created_date)
        
                cmdPrep.execute

                Session("Success")="Add a new received successfully"
                Response.redirect("admin_200164.asp")
            Else
                Session("Error")="You have to input info"
            End if
        Else
            If (NOT isnull(book_id) and (book_id<>"")) and (NOT isnull(user_id) and (user_id<>"")) and (NOT isnull(created_date) and (created_date<>"")) Then
                'strSQL="UPDATE books Set book_id='" & book_id &"',user_id='" & user_id & "', created_date='" & created_date &"' WHERE id=" & id
                'connDB.execute(strSQL)

                Set cmdPrep = Server.CreateObject("ADODB.Command")
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE books Set book_id=?,user_id=?,created_date=? WHERE id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("book_id", 202, 1, 200, book_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("user_id", 202, 1, 200, user_id)
                cmdPrep.parameters.Append cmdPrep.createParameter("created_date", 202, 1, 200, created_date)
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
                    <label for="book_id" class="form-label">Book id</label>
                    <input type="text" class="form-control" id="book_id" name="book_id" value="<%=book_id%>">
                </div>
                <div class="mb-3">
                    <label for="user_id" class="form-label">User_id</label>
                    <input type="text" class="form-control" id="user_id" name="user_id" value="<%=user_id%>">
                </div>
                <div class="mb-3">
                    <label for="user_id" class="form-label">Date</label>
                    <input type="date" class="form-control" id="created_date" name="created_date" value="<%=created_date%>">
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