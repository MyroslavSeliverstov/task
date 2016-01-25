<?php
$mysqli = new mysqli('127.0.0.1', 'Admin', 'admin', 'main');
$sql = "SELECT fio, bn FROM main WHERE id = 1";
$result = $mysqli->query($sql);
$db_row = $result->fetch_assoc();
echo 'Hello, ' . $db_row['fio'] . ' build # is ' . $db_row['bn'] . '';
?>
