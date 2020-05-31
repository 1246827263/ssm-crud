package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employService;

	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuse(@RequestParam("empName") String empName) {
		// 先判断用户名是否合法的表达式
		String reg = "(^[a-zA-Z0-9_-]{4,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if (!empName.matches(reg)) {
			return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文!!");
		}
		boolean flag = employService.checkuse(empName);
		if (flag) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "用户名不用！");
		}

		// return Msg.success().add("flag", flag);
	}

	/**
	 * 保存员工信息
	 * 
	 * @Valid：判断正则是否可用
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError error : errors) {
				System.out.println("错误的字段名" + error.getField());
				System.out.println("错误信息" + error.getDefaultMessage());
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("error", map);
		}
		employService.saveEmp(employee);
		return Msg.success();
	}

	/**
	 * 使用
	 * 
	 * @param pn
	 * @param modle
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// 1、上述参数解决分页查询获取public String
		// getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn){}
		// 2、引入分页查询插件
		PageHelper.startPage(pn, 5);
		// starPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employService.getAll();
		// 使用pageinfo包装查询，只需要将pageinfo将给页面就行
		// 分装了详细的分页信息,以及查询出来的数据,连续显示的页数
		PageInfo pageInfo = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", pageInfo);
	}

	// 接受的是emps请求
	// @RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model modle) {
		// 1、上述参数解决分页查询获取public String
		// getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn){}
		// 2、引入分页查询插件
		PageHelper.startPage(pn, 5);
		// starPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employService.getAll();
		// 使用pageinfo包装查询，只需要将pageinfo将给页面就行
		// 分装了详细的分页信息,以及查询出来的数据,连续显示的页数
		PageInfo pageInfo = new PageInfo(emps, 5);
		modle.addAttribute("pageInfo", pageInfo);
		return "list";
	}

	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmpById(@PathVariable(value = "id") Integer id) {
		Employee employee = employService.getEmpById(id);
		return Msg.success().add("employee", employee);
	}

	/**
	 * 如果直接发送ajax=PUT形式的请求 封装的数据 Employee [ empId=1014, empName=null, gender=null,
	 * email=null, dId=nu11] 问题: 请求体中有数据; 但是Employee对象封装不上; update tb1_ emp where
	 * emp_ id =1004; 原因: Tomcat: 1、将请求体中的数据，封装一个map. 2、request. getParameter( "
	 * empName " )就会从这个map中取值。 3、SpringMVC封装POJO对象的时候。 会把P0J0中每个属性的值，request.
	 * getParamter("email"); AJAX发送PUT请求引发的血案: PUT请求，请求体中的数据，request. getParameter(
	 * " empName" )拿不到 Tomcat-看是PUT不会封装请求体 中的数据为map,只有POST形式的请求才封装请求体为map org.
	 * apache. catalina. connector. Request-- parseParameters( ) protected String
	 * parseBodyMethods = "POST" ; if( !getConnector() . isParseBodyMethod(
	 * getMethod()) ) { success = true ; return; } 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
	 * 1、配置上HttpPutFormContentFilter; 2、他的作用;将请求体中的数据解析包装成- -个map. “request被重新包装，
	 * request. getParameter( )被重写，就会从自己封装的map中取数据 员工更新方法
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg updateEmpById(Employee employee) {
		System.out.println(employee.getEmpName());
		boolean flag = employService.updateEmpById(employee);
		return Msg.success();
	}

	/**
	 * 删除单个emp
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg deleteEmpById(@PathVariable(value = "ids") String ids) {
		// System.out.println(id);
		if (ids.contains("-")) {
			String[] split = ids.split("-");
			List<Integer> id = new ArrayList<Integer>();
			for (String str : split) {
				id.add(Integer.parseInt(str));
			}
			employService.deleteEmps(id);
			return Msg.success();
		} else {
			int id = Integer.parseInt(ids);
			employService.deleteEmpById(id);
			return Msg.success();
		}
	}
}
