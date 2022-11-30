void my_C(float *v1,float *v2,int N){

    //Primera derivada
    for(int i=0;i<N-1;i++){
        v2[i]=v1[i+1]-v1[i];     
               
    }
    
    //Segunda derivada
    for(int i=0;i<N-1;i++){
        if(i==N-2){
            v2[i]=0;
        }else{
           v2[i]=v2[i+1]-v2[i];     
        }
    }

}