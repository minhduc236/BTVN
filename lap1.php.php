####cau1###
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <center>
        <div>
            <form method="post">
                <h2>CHÀO THEO GIỜ</h2>
                <input type="Number" name="txtGio">
                <br>
                <?php
                   if (isset($_POST["txtGio"]))
                {
                   $gio = $_POST["txtGio"];
        
                   if ($gio <12 )
                   $chao = "chào buổi sáng";
                   else if ($gio <17)
                   $chao = "chào buổi chiều";
                   else 
                   $chao = "Chào buổi tối";
                   echo $chao;
                }
                ?>
                <br>
                <button type="submit">CHÀO</button>
            </form>
        </div>
    </center>
</body>

</html>

###câu3###

<form method="post" >
Số A:<input type ="number" name="soA" value="0"><br>
Số B:<input type ="number" name="soB" value="0"><br>
Số C:<input type ="number" name="soC" value="0"><br>
<input type="submit" value ="tinh">
</form>

<?php
$a = $_POST['soA'];
$b = $_POST['soB'];
$c = $_POST['soC'];
$x = "";
$y = "";

$y = ($b*$b) - (4*$a*$c);
if($y < 0){
    $x = 'Phương trình vô nghiệm';
}else if($y == 0){
    $x = 'Phương trình có nghiệm kép' . (-$b/2*$a);
}else{
    $x = 'Phương trình có hai nghiệm x1='. ((-$b + sqrt($y))/2*$a);
    $x .= ',x2 = ' . ((-$b - sqrt($y))/2*$a);
}

echo($x);


?>