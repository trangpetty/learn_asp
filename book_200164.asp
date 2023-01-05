<!-- #include file="connect_200164.asp" -->
<%
    If (Session("email")="") Then
    Response.redirect("login_200164.asp")
    End If
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret)
        if cond = true then
            Response.write ret
        else
            Response.write ""
        end if
    end function

    page = Request.Item("page")
    limit = 4

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(books.id) as count FROM books"

    Set CountResult = connDB.execute(strSQL)

    totalRows = CLng(CountResult("count"))

    Set CountResult = Nothing

    pages = Ceil(totalRows/limit)
%>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <link rel="stylesheet" href="./asset/bootstrap-5.2.1-dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="./asset/fontawesome-free-6.2.0-web/css/all.min.css">
        <script src="./asset/bootstrap-5.2.1-dist/js/bootstrap.bundle.min.js"></script>
        <title>Trang 200164</title>
    </head>
    <body>
        <!-- #include file="header_200164.asp" -->

        <div class="container">
            <div class="d-flex bd-highlight my-3">
                <div class="me-auto p-2 bd-highlight"><h2>Danh sach book</h2></div>
                <div class="d-flex">
                    <input type="text" class="form-control" id="search-input" autocomplete="off" placeholder="Search">
                    <button class="btn btn-primary" id="btn_search"><i class="fa fa-search"></i></button>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Author</th>
                            <th scope="col">Description</th>
                            <th scope="col">Quanity</th>
                            <th scope="col">User ID</th>
                            <!-- <th scope="col">Thao Tác</th> -->
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                Set cmdPrep = Server.CreateObject("ADODB.Command")
                                cmdPrep.ActiveConnection = connDB
                                cmdPrep.CommandType = 1
                                cmdPrep.Prepared = True
                                cmdPrep.CommandText = "SELECT * FROM books ORDER BY books.id OFFSET ?  ROWS FETCH NEXT ? ROWS ONLY"
                                cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, , offset)
                                cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, , limit)
                
                                Set Result = cmdPrep.execute
                                do while not Result.EOF
                            %>
                                    <tr>
                                        <td><%=Result("id")%></td>
                                        <td><%=Result("author")%></td>
                                        <td><%=Result("description")%></td>
                                        <td><%=Result("quanity")%></td>
                                        <td><%=Result("user_id")%></td>
                                    </tr>
                            <%
                                    Result.MoveNext
                                loop
                            %>
                    </tbody>
                </table>
            </div>

            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <% if (pages > 1) then %>
                        <% for i = 1 to pages %>
                            <li class='page-item <%=checkPage(Clng(i)=Clng(page),"active")%>''><a class="page-link" href="book_200164.asp?page=<%=i%>"><%=i%></a></li>
                        <% next %>
                    <% end if %>
                </ul>
            </nav>

            <div class="modal" tabindex="-1" id="confirm-delete">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Confirmation</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <p>Are you sure?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <a class="btn btn-danger btn-delete">Delete</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
        <script>
            $(function()
            {
                $('#confirm-delete').on('show.bs.modal', function(e){
                    $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
                });
            });
        </script>
    </body>
</html>
<%
    connDB.close()
    set connDB = Nothing
%>