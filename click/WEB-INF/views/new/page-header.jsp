<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org"
      xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout">

<div class="header-wrap fixed" th:fragment="pageHeaderFragment">
    <div class="logo-area">
        <a class="logo-sample-wrap" href="dashboard">
<!--            <i class="logo-icon fa-solid fa-stethoscope"></i>-->
<!--            <span class="logo-title">DTx Sample</span>-->
            <i class="dtx-logo"></i>
        </a>
    </div>
    <div class="header-section">
        <div class="header-search-box">
            <input type="text" class="header-search" placeholder="Search...">
            <button class="btn-search">
                <i class="fa-solid fa-magnifying-glass"></i>
            </button>
        </div>
        <div class="top-menu-wrap">
            <ul class="top-menu">
                <li class="top-menu-item">
                    <div class="update-patient">
                        <span class="badge"></span>
                    </div>
                </li>
                <li class="top-menu-item">
                    <div class="alarm">
                        <span class="badge"></span>
                    </div>
                </li>
                <li class="top-menu-item">
                    <div class="profile-img-wrap">
                        <img src="/assets/images/sample/sample-user-pic.jpeg" alt="profile-img">
                    </div>
                        <ul class="dropdown-menu">
                            <li>
                                <a href="profile">
                                    <i class="fa-solid fa-user"></i> Profile </a>
                            </li>
                            <li>
                                <a href="index">
                                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Log Out </a>
                            </li>
                        </ul>
                </li>
            </ul>
        </div>
    </div>
</div>

</html>