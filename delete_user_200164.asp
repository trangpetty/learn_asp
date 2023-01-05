<!-- #include file="connect_200164.asp" -->
<%
'Sinh vien xu ly delete chi trong truong hop dang nhap + chuyen sang ADODB.Command
    id = Request.QueryString("id")

    if trim(id) = "" or isnull(id) then
        Response.Write("<script>alert('Cannot delete');document.location='admin_200164.asp';</script>")
        Response.End
    end if

    strSQL = "DELETE FROM users WHERE id=" & id

    connDB.execute(strSQL)

    Response.Redirect("admin_200164.asp")
    Response.End

%>
