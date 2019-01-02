package org.springmvc.parts.model;

import javax.persistence.*;

@Entity
@Table(name = "part")
public class Part {
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "NAME", unique = true, nullable = false, length = 100)
    private String name;

    @Column(name = "NECESSARY")
    private boolean necessary;

    @Column(name = "COUNT")
    private int count;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isNecessary() {
        return necessary;
    }

    public void setNecessary(boolean necessary) {
        this.necessary = necessary;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "Part{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", necessary=" + necessary +
                ", count=" + count +
                '}';
    }

    @Override
    public boolean equals(Object obj) {

        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Part other = (Part) obj;
        if (hashCode() != other.hashCode())
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        return 31*id + name.length();
    }
}