package com.musa.spring.company.impl;

import com.musa.spring.company.Company;
import com.musa.spring.company.CompanyRepository;
import com.musa.spring.company.CompanyService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CompanyServiceImpl implements CompanyService{
   private final CompanyRepository companyRepository;

    public CompanyServiceImpl(CompanyRepository companyRepository) {
        this.companyRepository = companyRepository;
    }

    @Override
    public List<Company> getAllCompanies() {
        return companyRepository.findAll();
    }

    @Override
    public boolean updateCompany(Company company, Long id) {
        Optional<Company> jobOptional = companyRepository.findById(id);
        if (jobOptional.isPresent()) {
            Company companyToUpdate = jobOptional.get();
            companyToUpdate.setName(company.getName());
            companyToUpdate.setDescription(company.getDescription());
//            companyToUpdate.setMinSalary(company.getMinSalary());
//            companyToUpdate.setMaxSalary(company.getMaxSalary());
//            companyToUpdate.setLocation(company.getLocation());
            companyRepository.save(companyToUpdate);
            return true;
        }
        return false;
    }

    @Override
    public void createCompany(Company company) {
        companyRepository.save(company);

    }

    @Override
    public boolean deleteCompanyById(Long id) {
       if (companyRepository.existsById(id)) {
           companyRepository.deleteById(id);
           return true;
       }
        return false;
    }

    @Override
    public Company getCompanyById(Long id) {
        return companyRepository.findById(id).orElse(null);
    }
}
