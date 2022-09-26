public class SolvePTB2 {
    public static void main(String[] args) {
        // write your code here
    }

    public static double delta(double a, double b, double c) {
        return b*b - 4*a*c;
    }

    public static void solve(double delta, double a, double b){
        if( delta < 0){
            System.out.println("Pt vô nghiệm");
        }else if( delta == 0){
            System.out.println("Pt có 1 nghiệm, "+  -b/(2*a));
        }else {
            System.out.println("Pt có 2 nghiệm, ");
            System.out.println("nghiệm 1: "+ (-b+Math.sqrt(delta))/(2*a));
            System.out.println("nghiệm 2: "+ (-b-Math.sqrt(delta))/(2*a));
        }
    }
}
