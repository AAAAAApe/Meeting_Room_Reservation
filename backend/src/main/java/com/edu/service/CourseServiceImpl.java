package com.edu.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.edu.entity.course.Course;
import com.edu.mapper.CourseMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 课程服务实现类
 * 处理课程的创建、查询、更新和删除等业务逻辑
 * 继承自ServiceImpl以利用MyBatis-Plus提供的通用CRUD功能
 */
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course> implements CourseService {
    /**
     * 课程数据访问对象，用于操作数据库中的课程记录
     */
    private final CourseMapper courseMapper;

    /**
     * 构造函数，通过依赖注入初始化课程数据访问对象
     * @param courseMapper 课程数据访问对象
     */
    public CourseServiceImpl(CourseMapper courseMapper) {
        this.courseMapper = courseMapper;
    }

    /**
     * 根据部门ID获取课程列表方法
     * 使用MyBatis-Plus的LambdaQueryWrapper构建查询条件，筛选特定部门的课程
     * 
     * @param departmentId 部门ID，用于筛选特定部门的课程
     * @return 返回该部门的所有课程列表
     */
    @Override
    public List<Course> getCoursesByDepartment(String departmentId) {
        LambdaQueryWrapper<Course> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Course::getCourseDepartment, departmentId);
        return courseMapper.selectList(queryWrapper);
    }

    /**
     * 根据课程ID获取课程信息方法
     * 直接调用MyBatis-Plus提供的selectById方法查询课程
     * 
     * @param courseId 课程ID
     * @return 返回课程信息，如果不存在则返回null
     */
    @Override
    public Course getCourseById(String courseId) {
        return courseMapper.selectById(courseId);
    }

    /**
     * 创建新课程方法
     * 调用父类的save方法将课程信息保存到数据库
     * 
     * @param course 课程信息对象
     * @return 创建是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean createCourse(Course course) {
        return save(course);
    }

    /**
     * 更新课程信息方法
     * 调用父类的updateById方法更新数据库中的课程记录
     * 
     * @param course 更新后的课程信息对象，必须包含课程ID
     * @return 更新是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean updateCourse(Course course) {
        return updateById(course);
    }

    /**
     * 删除课程方法
     * 调用父类的removeById方法删除数据库中的课程记录
     * 
     * @param courseId 要删除的课程ID
     * @return 删除是否成功，成功返回true，失败返回false
     */
    @Override
    public boolean deleteCourse(String courseId) {
        return removeById(courseId);
    }
}