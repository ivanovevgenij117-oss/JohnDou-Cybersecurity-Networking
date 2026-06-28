#include <stdio.h>
#include <stdlib.h>
#include <fcgi_stdio.h>

int main(){
        while (FCGI_Accept() >=0) {
                printf("Content-type: text/html\r\n\r\n");
                printf("<html>\n<title>Hello world!</title>\n</head>\n<body>\n");
                printf("</body>\n</html>\n");
        }
        return 0;
}
