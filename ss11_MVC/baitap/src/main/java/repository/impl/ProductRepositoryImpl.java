package repository.impl;

import bean.Product;
import repository.ProductRepository;

import java.util.*;

public class ProductRepositoryImpl implements ProductRepository {

    private  static Map<String,Product> productMap;

    static {
        productMap = new LinkedHashMap<>();
        productMap.put("Pr001",new Product("Pr001","product 1",12345,"dep","WUBI"));
        productMap.put("Pr002",new Product("Pr002","product 2",12345,"dep lam","CHILL"));
        productMap.put("Pr003",new Product("Pr003","product 3",12345,"dep luon","LOL"));
        productMap.put("Pr004",new Product("Pr004","product 4",12345,"qua dep","CN"));
        productMap.put("Pr005",new Product("Pr005","product 5",12345,"dep s","VNES"));
    }

    @Override
    public List<Product> findAll() {
        return new ArrayList<>(productMap.values());
    }

    @Override
    public void create(Product product) throws Exception {
        if(productMap.containsKey(product.getId())){
            throw new Exception("Duplicate id");
        }else{
            productMap.put(product.getId(),product);
        }
    }

    @Override
    public void update(Product product) throws Exception {
        if(!productMap.containsKey(product.getId())){
            throw new Exception("Product not Found");
        }else{
            productMap.put(product.getId(),product);
        }
    }

    @Override
    public void delete(String id) throws Exception {
        if(productMap.containsKey(id)){
            productMap.remove(id);
        }else{
            throw new Exception("Product not Found");
        }
    }

    @Override
    public Product findById(String id) throws Exception {
        if(productMap.containsKey(id)){
            return productMap.get(id);
        }
        throw new Exception("Product not Found");
    }

    @Override
    public List<Product> findByName(String name) throws Exception {
        List<Product> result = new LinkedList<>();
        Set<String> sizeMap = productMap.keySet();
        for(String status: sizeMap){
            if(productMap.get(status).getName().matches(".*["+name+"].*")){
                result.add(productMap.get(status));
            }
        }
//        for(Map.Entry<String, Product> item: productMap.entrySet()){
//            if(item.getValue().getName().matches("."+name.trim()+".")) {
//                output.add(item.getValue());
//            }
//        }
        if(result.size() != 0){
            return result;
        }
        throw new Exception("Product not Found");
    }
}
