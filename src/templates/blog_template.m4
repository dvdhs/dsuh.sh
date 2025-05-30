define(`CPP_DEFINE', `#define $1 $2')dnl
define(`CPP_INCLUDE', `#include $1')dnl
<!DOCTYPE html>
<html> 
<head>

CPP_DEFINE(filename`_TITLE', `Sample Title')
CPP_DEFINE(filename`_DATE',  esyscmd(`date +%Y-%m-%d'))
CPP_DEFINE(filename`_ABSTRACT', Sample Abstract')

CPP_INCLUDE(`"components/common_head.html.part"')

<link rel="stylesheet" type="text/css" href="/main.css">
</head>


<body>
<div class='text-container'>
CPP_INCLUDE(`"components/navbar.html.part"')

<h2 style='margin-bottom:2px;'> filename`_TITLE' </h2>
<p style='margin-top:1px;'> filename`_DATE' </p>
<hr>

CPP_INCLUDE(`"html/'filename`.html.body"')

</div>
CPP_INCLUDE(`"components/footer.html.part"')
</body>

</html>
