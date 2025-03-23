<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <jsp:include page="Includes/header.jsp" />

        <div class="container d-flex justify-content-center align-items-center vh-100">
            <div class="card shadow-lg p-4" style="width: 400px;">
                <div class="card-body text-center">
                    <h2 class="card-title mb-3">User Profile</h2>
                    <ul class="list-group list-group-flush text-start">
                        <li class="list-group-item"><strong>Username:</strong> ${sessionScope.acc.username}</li>
                        <li class="list-group-item"><strong>Email:</strong> ${sessionScope.acc.email}</li>
                        <li class="list-group-item"><strong>Phone:</strong> ${sessionScope.acc.phone}</li>
                        <li class="list-group-item"><strong>Address:</strong> ${sessionScope.acc.address}</li>
                        <li class="list-group-item"><strong>Role:</strong> ${sessionScope.acc.role}</li>
                        <li class="list-group-item"><strong>Registered At:</strong> ${sessionScope.acc.createdAt}</li>
                    </ul>
                    <div class="mt-4">
                        <a href="editProfile.jsp" class="btn btn-primary w-100 mb-2">Edit Profile</a>
                        <a href="logout" class="btn btn-danger w-100">Logout</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
