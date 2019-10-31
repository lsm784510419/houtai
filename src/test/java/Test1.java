public class Test1 {

    public static void main(String[] args) {
        //递归阶乘
        int jc = jc(5);
        System.out.println("递归阶乘"+jc);
        //递归斐波那契数列
        System.out.println("斐波那契数列"+FB(10));
    }
    //递归阶乘
    public static int jc(int n){
        //规律
        /**
         * 5！代表5的阶乘
         *  0的阶乘就是 1
         *  1的阶乘就是1
         *  2的阶乘就是1*2
         *  3的阶乘就是1*2*3
         *  4的阶乘就是1*2*3*4
         *  依次类推...
         */
        if (n==0 || n==1){
            return 1;
        }else{
            return n * jc(n-1);
        }
    }
    //递归斐波那契数列
    public static long FB(int n){

        /**
         * 规律 1,1,2,3,5,8,13
         * 如果求第10位数的话就是第8位数和第9位数的和
         */
        if (n==1 || n==2){
            return 1;
        }else{
            return FB(n-2)+FB(n-1);
        }
    }
}
