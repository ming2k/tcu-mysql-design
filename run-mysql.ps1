docker run --name tcu-studenthub `
    -e MYSQL_ROOT_PASSWORD=root `
    -e MYSQL_DATABASE=TCUStudentHub `
    -e MYSQL_USER=alice `
    -e MYSQL_PASSWORD=alice `
    -p 3306:3306 `
    -d mysql:8
