#include<iostream>
using namespace std;
int main() {
    int i, n;
      cin >> n;
          for(i=1;i<=n;i++){
              if(i==5) continue;
              else if (i==10) break;
              else {
              cout << i;
              cout << " ";
              }
          }

    return 0;
}