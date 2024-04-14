  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <div class="dropdown">
   	<a href="./" class="brand-link">
        <h3 class="text-center p-0 m-0"><b>Admin Panel</b></h3>

    </a>
      
    </div>
    <div class="sidebar">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column nav-flat" data-widget="treeview" role="menu" data-accordion="false">
         <li class="nav-item dropdown">
            <a href="./" class="nav-link nav-home">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Dashboard
              </p>
            </a>
          </li>

          <li class="nav-item dropdown">
            <a href="./index.php?page=admin_list" class="nav-link nav-admin_list">
              <i class="nav-icon fas fa-user-friends"></i>
              <p>
               Administrators
              </p>
            </a>
          </li> 

          <li class="nav-item dropdown">
            <a href="./index.php?page=reviewer_list" class="nav-link nav-reviewer_list">
              <i class="nav-icon fas fa-user-friends"></i>
              <p>
               Reviewers
              </p>
            </a>
          </li> 

          <li class="nav-item dropdown">
            <a href="./index.php?page=student_list" class="nav-link nav-student_list">
              <i class="nav-icon fas fa-user-friends"></i>
              <p>
               Students
              </p>
            </a>
          </li> 

		      <li class="nav-item dropdown">
            <a href="./index.php?page=to_review_list" class="nav-link nav-subject_list">
              <i class="nav-icon fas fa-th-list"></i>
              <p>
                To Review
              </p>
            </a>
          </li> 
          <li class="nav-item dropdown">
            <a href="./index.php?page=to_review" class="nav-link nav-class_list">
              <i class="nav-icon fas fa-list-alt"></i>
              <p>
                Reviewed
              </p>
            </a>
          </li> 
          <li class="nav-item dropdown">
            <a href="./index.php?page=criteria_list" class="nav-link nav-criteria_list">
              <i class="nav-icon fas fa-list-alt"></i>
              <p>
                Evaluation Critria
              </p>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </aside>
  <script>
  	$(document).ready(function(){
      var page = '<?php echo isset($_GET['page']) ? $_GET['page'] : 'home' ?>';
  		var s = '<?php echo isset($_GET['s']) ? $_GET['s'] : '' ?>';
      if(s!='')
        page = page+'_'+s;
  		if($('.nav-link.nav-'+page).length > 0){
             $('.nav-link.nav-'+page).addClass('active')
  			if($('.nav-link.nav-'+page).hasClass('tree-item') == true){
            $('.nav-link.nav-'+page).closest('.nav-treeview').siblings('a').addClass('active')
  				$('.nav-link.nav-'+page).closest('.nav-treeview').parent().addClass('menu-open')
  			}
        if($('.nav-link.nav-'+page).hasClass('nav-is-tree') == true){
          $('.nav-link.nav-'+page).parent().addClass('menu-open')
        }

  		}
     
  	})
  </script>