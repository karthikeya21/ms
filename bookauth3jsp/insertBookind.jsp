<!DOCTYPE html>
<html>
<head>
    <title>Insert Book</title>
</head>
<body>
    <h1>Insert Book Details</h1>
    <form action="InsertBook.jsp" method="post">
        Book Title: <input type="text" name="booktitle" required><br>
        Author: <input type="text" name="author" required><br>
        Price: <input type="number" step="0.01" name="price" required><br>
        <input type="submit" value="Submit">
    </form>
</body>
</html>
