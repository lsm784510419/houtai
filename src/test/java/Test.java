public class Test {

    public static void main(String[] args) {
        /*Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();*/
        //递归求阶乘
       /* int jc = jc(4);
        System.out.println(jc);*/


      // for (int i=1;i<10;i++){
            long fb = FB(10);
            System.out.println(fb);
       // }
    }
    //递归求阶乘
    public static int jc(int n ){

        if (n < 0) {
            System.out.println("无效输入，请重新输入！");
            return 0;
        } else if (n == 1 || n == 0) {
            return 1;
        } else{
            return n * jc(n - 1);
    }
    }
    //递归求斐波那契数列
    public static long FB(int n){
        if (n==1 || n==2)
            return  1;
        else {
            return FB(n-1)+FB(n-2);
        }
    }



}
