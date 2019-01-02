package org.springmvc.parts.controller;

import org.springmvc.parts.model.Part;
import org.springmvc.parts.service.PartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class PartController {
    private PartService partService;
    private static String currentParam = "all";
    private static Integer currentPage = 1;
    @Autowired
    @Qualifier(value = "partService")
    public void setPartService(PartService partService) {
        this.partService = partService;
    }

    @RequestMapping("/add/")
    public ModelAndView addPart() {
        ModelAndView modelAndView = new ModelAndView("edit");
        modelAndView.addObject("part", new Part());
        return modelAndView;
    }
    @RequestMapping("/edit/{id}")
    public ModelAndView editPart(@PathVariable("id") int id) {
        ModelAndView modelAndView = new ModelAndView("edit");
        if (id != 0) {
            modelAndView.addObject("part", this.partService.getPartById(id));
        }
        return modelAndView;
    }

    @RequestMapping("/remove/{id}")
    public String removePart(@PathVariable("id") int id) {
        this.partService.removePart(id);
        return "redirect:/parts/";
    }

    @RequestMapping(value = "/parts/update", method = RequestMethod.POST)
    public String updatePart(@ModelAttribute("part") Part part) {
        if(part.getId() != 0){
            this.partService.updatePart(part);
        }else{
            this.partService.addPart(part);
        }
        return "redirect:/parts/";
    }

    @RequestMapping(value = "/parts/")
    public ModelAndView listOfParts(@RequestParam(required = false) Integer page, @RequestParam(required = false) String param) {
        ModelAndView modelAndView = new ModelAndView("parts");

        if (page != null) {
            currentPage = page;
        }

        if (param != null) {
            if (param.equals("")) {
                param = "all";
            }
            currentParam = param;
            currentPage = 1;
        }

        int availableComputers = countComputers();
        modelAndView.addObject("availableComputers", availableComputers);
        List<Part> parts = partService.listParts(currentParam);
        PagedListHolder<Part> pagedListHolder = new PagedListHolder<>(parts);
        pagedListHolder.setPageSize(10);
        modelAndView.addObject("maxPages", pagedListHolder.getPageCount());
        if (currentPage == null || currentPage < 1 || currentPage > pagedListHolder.getPageCount()) {
            currentPage = 1;
        }
        modelAndView.addObject("page", currentPage);
        if (currentPage == null || currentPage < 1 || currentPage > pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(0);
            modelAndView.addObject("listParts", pagedListHolder.getPageList());
        } else if (currentPage <= pagedListHolder.getPageCount()) {
            pagedListHolder.setPage(currentPage - 1);
            modelAndView.addObject("listParts", pagedListHolder.getPageList());
        }

        return modelAndView;
    }

    private int countComputers() {
        List<Part> needParts = partService.listParts("needOnly");
        int count = 0;
        if (!needParts.isEmpty()) {
            count = needParts.get(0).getCount();
            for (Part part : needParts) {
                if (part.getCount() < count) {
                    count = part.getCount();
                }
            }
        }
        return count;
    }
}