package bd.edu.diu.cis.library.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import javax.validation.constraints.Size;
import java.util.Collection;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "customers", uniqueConstraints = @UniqueConstraint(columnNames = {"username", "image", "phone_number"}))
public class Customer {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "customer_id")
    private Long id;

    @Size(min = 3, max = 15, message = "First name should have 3-15 characters")
    private String firstName;

    @Size(min = 3, max = 15, message = "Last name should have 3-15 characters")
    private String lastName;

    private String username;
    private String country;

    @Column(name = "phone_number")
    private String phoneNumber;

    private String address;
    private String password;

    @Lob
    @Column(name = "image", columnDefinition = "MEDIUMBLOB")
    private String image;

    @Column(name = "city")
    private String city;

    @OneToOne(mappedBy = "customer")
    @JsonIgnore
    private ShoppingCart shoppingCart;

    @OneToMany(mappedBy = "customer")
    @JsonIgnore // Thêm @JsonIgnore để tránh vòng lặp với Order
    private List<Order> orders;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(name = "customers_roles",
            joinColumns = @JoinColumn(name = "customer_id", referencedColumnName = "customer_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "role_id"))
    private Collection<Role> roles;
}






// package bd.edu.diu.cis.library.model;

// import lombok.AllArgsConstructor;
// import lombok.Data;
// import lombok.NoArgsConstructor;

// import javax.persistence.*;
// import javax.validation.constraints.Size;
// import java.util.Collection;
// import java.util.List;


// @Data
// @AllArgsConstructor
// @NoArgsConstructor
// @Entity
// @Table(name = "customers", uniqueConstraints = @UniqueConstraint(columnNames = {"username", "image", "phone_number"}))
// public class Customer {
//     @Id
//     @GeneratedValue(strategy = GenerationType.IDENTITY)
//     @Column(name = "customer_id")
//     private Long id;

//     @Size(min = 3, max = 15, message = "First name should have 3-15 characters")
//     private String firstName;
//     @Size(min = 3, max = 15, message = "Last name should have 3-15 characters")
//     private String lastName;
//     private String username;
//     private String country;
//     @Column(name = "phone_number")
//     private String phoneNumber;
//     private String address;

//     private String password;
//     @Lob
//     @Column(name = "image", columnDefinition = "MEDIUMBLOB")
//     private String image;

//     @Column(name = "city")
//     private String city;

//     @OneToOne(mappedBy = "customer")
//     private ShoppingCart shoppingCart;
//     @OneToMany(mappedBy = "customer")
//     private List<Order> orders;

//     @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
//     @JoinTable( name = "customers_roles",
//             joinColumns = @JoinColumn(name = "customer_id", referencedColumnName = "customer_id"),
//             inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "role_id"))
//     private Collection<Role> roles;
// }