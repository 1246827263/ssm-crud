package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	/**
	 * 检验用户名是否可用
	 * 
	 * @param empName
	 * @return
	 */
	public boolean checkuse(String empName) {
		EmployeeExample employeeExample = new EmployeeExample();

		employeeExample.createCriteria().andEmpNameEqualTo(empName);
		long countByExample = employeeMapper.countByExample(employeeExample);

		return countByExample == 0;
	}

	public Employee getEmpById(Integer id) {
		Employee emp = employeeMapper.selectByPrimaryKey(id);
		return emp;
	}

	public boolean updateEmpById(Employee employee) {
		int count = employeeMapper.updateByPrimaryKeySelective(employee);
		return count == 0;
	}

	public void deleteEmpById(Integer id) {
		// TODO Auto-generated method stub;
		employeeMapper.deleteByPrimaryKey(id);

	}

	public void deleteEmps(List<Integer> id) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andEmpIdIn(id);
		employeeMapper.deleteByExample(example);
	}

}
